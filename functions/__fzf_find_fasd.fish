function __fzf_find_fasd
  set -l commandline (__fzf_parse_commandline)
  set -l fzf_query $commandline[2]

  fasd -l $argv | eval (__fzfcmd) "-m $FZF_DEFAULT_OPTS --query \"$fzf_query\"" | while read -l s; set results $results $s; end
  for result in $results
    commandline -it -- (string escape -n $result)
    commandline -it -- " "
  end
  commandline -f repaint
end
