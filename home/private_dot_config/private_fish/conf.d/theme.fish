{{- /* Use theme from info.yml data */ -}}
set -q FSH_THEME; or set -gx FSH_THEME {{ .data.theme.name | default "dracula" }}
fish_config theme choose $FSH_THEME
