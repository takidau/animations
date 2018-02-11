sed -e 's/[ ]/\&#x202F;/g' \
    | awk 'BEGIN { bold = 1 } $0 ~ /^-+/ { bold = 0 } { if (bold) { printf("<b><i>%s</i></b>\n", $0) } else { print $0 } }' \
    | sed -e 's~\([0-9]\{1,\}:[0-9]\{1,\}\)>~<span style="color:#00f;font-style:normal">\1\&gt;</span>~g' \
    | sed -e 's~$~<br/>~g' \
    | sed -e 's~SELECT\&#x202F;TABLE~SELECT\&#x202F;<span style="color:#e94">TABLE</span>~g' \
    | sed -e 's~SELECT\&#x202F;TVR~SELECT\&#x202F;<span style="color:#777">TVR</span>~g' \
    | sed -e 's~SELECT\&#x202F;STREAM~SELECT\&#x202F;<span style="color:#87c">STREAM</span>~g' \
    | awk '{ if (NR == 1) printf("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width: 700px\">\n <tbody>\n  <tr>\n   <td style=\"font-family:'\''UbuntuMono'\'', monospace;line-height:1.25;font-size:11px\">\n"); } { print $0 } END { printf("   </td>\n  </tr>\n </tbody>\n</table>\n") }' \
    | tee /tmp/sql-output.txt \
    | pbcopy
echo
echo
cat /tmp/sql-output.txt
echo
echo
