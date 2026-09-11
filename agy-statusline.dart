import 'dart:convert';
import 'dart:io';

// --- 24-bit TrueColor Palette ---
const rst = '\x1B[0m';
const bold = '\x1B[1m';

const cFrame = '\x1B[38;2;71;85;105m'; // Slate Frame (#475569)
const dim = '\x1B[38;2;100;116;139m'; // Slate Muted (#64748b)
const sep = '  $dim·$rst  ';

const fgText = '\x1B[38;2;241;245;249m'; // White (#f1f5f9)
const fgMuted = '\x1B[38;2;148;163;184m'; // Slate (#94a3b8)
const fgEmerald = '\x1B[38;2;52;211;153m'; // Emerald (#34d399)
const fgAmber = '\x1B[38;2;251;191;36m'; // Warm Amber (#fbbf24)
const fgRose = '\x1B[38;2;248;113;113m'; // Coral Red (#f87171)
const fgSky = '\x1B[38;2;56;189;248m'; // Sky Blue (#38bdf8)
const fgViolet = '\x1B[38;2;167;139;250m'; // Lavender (#a78bfa)

final ansiRegex = RegExp(r'\x1B\[[0-?]*[ -/]*[@-~]');
int visualLen(String s) => s.replaceAll(ansiRegex, '').length;

String fmtTokens(num? n) {
  if (n == null || n == 0) return '0';
  if (n >= 1000000)
    return '${(n / 1000000).toStringAsFixed(1)}M'.replaceAll('.0M', 'M');
  if (n >= 1000)
    return '${(n / 1000).toStringAsFixed(1)}k'.replaceAll('.0k', 'k');
  return n.toInt().toString();
}

String fmtTime(num? seconds) {
  if (seconds == null || seconds <= 0) return '0s';
  final sec = seconds.toInt();
  final days = sec ~/ 86400;
  final hours = (sec % 86400) ~/ 3600;
  final mins = (sec % 3600) ~/ 60;
  if (days > 0) return '${days}d ${hours}h';
  if (hours > 0) return '${hours}h ${mins}m';
  return '${mins}m';
}

String formatPath(String path) {
  if (path.isEmpty) return '';
  final home = Platform.environment['HOME'] ?? '';
  final display = (home.isNotEmpty && path.startsWith(home))
      ? path.replaceFirst(home, '~')
      : path;
  final idx = display.lastIndexOf('/');
  if (idx != -1 && idx < display.length - 1) {
    return '$dim${display.substring(0, idx + 1)}$rst$fgMuted${display.substring(idx + 1)}$rst';
  }
  return '$fgMuted$display$rst';
}

class VcsInfo {
  final String branch;
  final bool isDirty;
  VcsInfo(this.branch, this.isDirty);
}

VcsInfo? resolveVcs(String cwd, Map<String, dynamic>? payloadVcs) {
  if (payloadVcs != null && payloadVcs['branch'] != null) {
    final b = payloadVcs['branch'].toString().trim();
    if (b.isNotEmpty) {
      return VcsInfo(b, payloadVcs['dirty'] == true);
    }
  }

  if (cwd.isEmpty) return null;
  var dir = Directory(cwd).absolute;
  Directory? gitDir;

  while (true) {
    final check = Directory('${dir.path}/.git');
    final checkFile = File('${dir.path}/.git');
    if (check.existsSync()) {
      gitDir = check;
      break;
    } else if (checkFile.existsSync()) {
      try {
        final content = checkFile.readAsStringSync().trim();
        if (content.startsWith('gitdir:')) {
          final relPath = content.substring(7).trim();
          gitDir = Directory(
            relPath.startsWith('/') ? relPath : '${dir.path}/$relPath',
          );
          break;
        }
      } catch (_) {}
    }
    final parent = dir.parent;
    if (parent.path == dir.path) break;
    dir = parent;
  }

  if (gitDir == null || !gitDir.existsSync()) return null;

  final headFile = File('${gitDir.path}/HEAD');
  if (!headFile.existsSync()) return null;

  String branch = '';
  try {
    final content = headFile.readAsStringSync().trim();
    if (content.startsWith('ref: refs/heads/')) {
      branch = content.replaceFirst('ref: refs/heads/', '');
    } else if (content.length >= 7) {
      branch = content.substring(0, 7);
    }
  } catch (_) {
    return null;
  }

  if (branch.isEmpty) return null;

  bool isDirty = false;
  try {
    final result = Process.runSync('git', [
      '-C',
      dir.path,
      'status',
      '--porcelain',
    ], runInShell: false);
    if (result.exitCode == 0) {
      isDirty = (result.stdout as String).trim().isNotEmpty;
    }
  } catch (_) {}

  return VcsInfo(branch, isDirty);
}

String renderGauge(double pct, {int width = 7}) {
  final clamped = pct.clamp(0.0, 100.0);
  final filled = ((clamped / 100.0) * width).round();
  final empty = width - filled;
  final color = clamped >= 85 ? fgRose : (clamped >= 65 ? fgAmber : fgSky);
  final filledBar = filled > 0 ? '$color${'━' * filled}$rst' : '';
  final emptyBar = empty > 0 ? '$cFrame${'─' * empty}$rst' : '';
  return '$filledBar$emptyBar';
}

/// Builds a 3-segment row with visually equal rails on the left and right of the center item.
String makeBalancedRow({
  required String left,
  required String center,
  required String right,
  required int totalWidth,
}) {
  final wLeft = visualLen(left);
  final wCenter = visualLen(center);
  final wRight = visualLen(right);

  if (wCenter == 0) {
    final railLen = (totalWidth - wLeft - wRight - 2).clamp(2, totalWidth);
    return '$left $cFrame${'─' * railLen}$rst $right';
  }

  final availableDashes = totalWidth - wLeft - wCenter - wRight - 4;
  if (availableDashes < 4) {
    // Narrow fallback: merge center with right
    final compactRight = '$center  $right';
    final railLen = (totalWidth - wLeft - visualLen(compactRight) - 2).clamp(
      2,
      totalWidth,
    );
    return '$left $cFrame${'─' * railLen}$rst $compactRight';
  }

  // Divide leftover rail space equally between Rail 1 and Rail 2
  final r1 = availableDashes ~/ 2;
  final r2 = availableDashes - r1;

  return '$left $cFrame${'─' * r1}$rst $center $cFrame${'─' * r2}$rst $right';
}

void main() async {
  final raw = await utf8.decoder.bind(stdin).join();
  if (raw.trim().isEmpty) return;

  Map<String, dynamic> data;
  try {
    data = jsonDecode(raw) as Map<String, dynamic>;
  } catch (_) {
    return;
  }

  // Exact-column layout: leave 1 column of safety margin on each side.
  final termWidth = data['terminal_width'] as int;
  final w = termWidth;

  // ========================== ROW 1: HEADER & VCS ==========================
  final workspace = (data['workspace'] as Map<String, dynamic>?) ?? {};
  final cwd =
      (data['cwd'] as String?) ?? (workspace['current_dir'] as String?) ?? '';
  final pathStr = formatPath(cwd);

  final vcsInfo = resolveVcs(cwd, data['vcs'] as Map<String, dynamic>?);
  final gitStr = vcsInfo != null
      ? (vcsInfo.isDirty
            ? '$fgSky⎇ ${vcsInfo.branch}$fgRose*$rst $fgAmber[dirty]$rst'
            : '$fgSky⎇ ${vcsInfo.branch}$rst $fgEmerald[clean]$rst')
      : '';

  final sandbox = (data['sandbox'] as Map<String, dynamic>?) ?? {};
  final boxTag = (sandbox['enabled'] == true)
      ? '$fgSky[sandbox:${sandbox['allow_network'] == true ? '+net' : 'isolated'}]$rst'
      : '$dim[host]$rst';

  final topLeft = '$cFrame╭─$rst $pathStr';
  final topRight = '$boxTag $cFrame─╮$rst';
  final topLine = makeBalancedRow(
    left: topLeft,
    center: gitStr,
    right: topRight,
    totalWidth: w,
  );

  // ========================== ROW 2: ORCHESTRATION ==========================
  final r2Left = <String>[];
  final state = (data['agent_state'] as String? ?? 'idle').toLowerCase();
  final isConfirm = data['tool_confirmation_pending'] == true;
  final vim = (data['vim'] as Map<String, dynamic>?) ?? {};
  final vimTag = vim['mode'] != null
      ? '$dim[${vim['mode'].toString().toLowerCase()}]$rst '
      : '';

  if (isConfirm) {
    r2Left.add('$vimTag$fgRose● action required$rst');
  } else if (state == 'thinking') {
    r2Left.add('$vimTag$fgAmber● thinking$rst');
  } else if (state == 'working' || state == 'tool_use') {
    r2Left.add('$vimTag$fgSky● working$rst');
  } else {
    r2Left.add('$vimTag$fgEmerald● idle$rst');
  }

  final mode = data['execution_mode'] ?? 'default';
  r2Left.add('$fgViolet✦ ${mode.toString().toLowerCase()}$rst');
  final midLeft = '$cFrame├─$rst ${r2Left.join(sep)}';

  final tasks = (data['task_count'] as int?) ?? 0;
  final pending = (data['pending_input_count'] as int?) ?? 0;
  final artifacts = (data['artifact_count'] as int?) ?? 0;

  final taskStr = tasks > 0 ? '$fgAmber$tasks tasks$rst' : '${dim}0 tasks$rst';
  final pendStr = pending > 0
      ? '$fgViolet$pending queued$rst'
      : '${dim}0 queued$rst';
  final artStr = artifacts > 0
      ? '$fgMuted$artifacts artifacts$rst'
      : '${dim}0 artifacts$rst';
  final midRightContent = '$taskStr$sep$pendStr$sep$artStr';
  final midRight = '$midRightContent $cFrame│$rst';

  final midPadLen = (w - visualLen(midLeft) - visualLen(midRight)).clamp(2, w);
  final midLine = '$midLeft${' ' * midPadLen}$midRight';

  // ========================== ROW 3: COMPUTE & TELEMETRY ==========================
  final model = (data['model'] as Map<String, dynamic>?) ?? {};
  final modelName = model['display_name'] ?? model['id'] ?? 'Gemini';
  final botLeft = '$cFrame╰─$rst $fgText$modelName$rst';

  final ctx = (data['context_window'] as Map<String, dynamic>?) ?? {};
  final curUsage = (ctx['current_usage'] as Map<String, dynamic>?) ?? {};
  final usedPct = (ctx['used_percentage'] as num?)?.toDouble() ?? 0.0;
  final ctxMax = (ctx['context_window_size'] as num?) ?? 1048576;
  final inTok =
      (curUsage['input_tokens'] as num?) ??
      (ctx['total_input_tokens'] as num?) ??
      0;

  final pctVal = usedPct.round();
  final pctColor = pctVal < 65 ? fgEmerald : (pctVal < 85 ? fgAmber : fgRose);
  final gauge = renderGauge(usedPct, width: 7);
  final botCenter =
      '$dim ctx$rst $pctColor$pctVal%$rst $gauge $dim${fmtTokens(inTok)}/${fmtTokens(ctxMax)}$rst';

  final outTok =
      (curUsage['output_tokens'] as num?) ??
      (ctx['total_output_tokens'] as num?) ??
      0;
  final cacheTok = (curUsage['cache_read_input_tokens'] as num?) ?? 0;
  final tokCache = cacheTok > 0
      ? '$fgEmerald↻${fmtTokens(cacheTok)} cache$rst'
      : '${dim}↻0 cache$rst';
  final tokStr =
      '$fgSky↑${fmtTokens(inTok)}$rst $fgViolet↓${fmtTokens(outTok)}$rst $tokCache';

  final quota = (data['quota'] as Map<String, dynamic>?) ?? {};
  String quotaStr = '';
  if (quota.isNotEmpty) {
    final bucket = quota.values.first as Map<String, dynamic>? ?? {};
    final remFrac = bucket['remaining_fraction'] as num?;
    if (remFrac != null) {
      final qPct = (remFrac * 100).round();
      final qTime = fmtTime(bucket['reset_in_seconds'] as num?);
      final qColor = qPct >= 50 ? fgEmerald : (qPct >= 20 ? fgAmber : fgRose);
      quotaStr = '$dim quota$rst $qColor$qPct%$rst $dim↻ $qTime$rst';
    }
  }

  final r3RightParts = [tokStr];
  if (quotaStr.isNotEmpty) r3RightParts.add(quotaStr);
  final botRight = '${r3RightParts.join(sep)} $cFrame─╯$rst';

  final botLine = makeBalancedRow(
    left: botLeft,
    center: botCenter,
    right: botRight,
    totalWidth: w,
  );

  // ========================== SPACER ROWS ==========================
  final spacerLine = '$cFrame│$rst${' ' * (w - 2)}$cFrame│$rst';

  stdout.write('$topLine\n$spacerLine\n$midLine\n$spacerLine\n$botLine\n');
}
