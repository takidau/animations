awk 'BEGIN { bold = 1 } $0 ~ /^-+/ { bold = 0 } { if (bold) { printf("<strong><em>%s</em></strong>\n", $0) } else { print $0 } }' \
    | sed -e 's~\([0-9]\{1,\}:[0-9]\{1,\}\)>~<span class="code_blue">\1\&gt;</span>~g' \
    | sed -e 's~SELECT TABLE~SELECT <span class="code_orange">TABLE</span>~g' \
    | sed -e 's~SELECT TVR~SELECT <span class="code_grey">TVR</span>~g' \
    | sed -e 's~SELECT STREAM~SELECT <span class="code_purple">STREAM</span>~g' \
    | sed -e 's~FULL OUTER JOIN~<span class="yellow_bg">FULL OUTER</span> JOIN~g' \
    | sed -e 's~LEFT OUTER JOIN~<span class="yellow_bg">LEFT OUTER</span> JOIN~g' \
    | sed -e 's~RIGHT OUTER JOIN~<span class="yellow_bg">RIGHT OUTER</span> JOIN~g' \
    | sed -e 's~INNER JOIN~<span class="yellow_bg">INNER</span> JOIN~g' \
    | sed -e 's~ANTI JOIN~<span class="yellow_bg">ANTI</span> JOIN~g' \
    | sed -e 's~SEMI JOIN~<span class="yellow_bg">SEMI</span> JOIN~g' \
    | sed -e 's~!~<span class="code_lightgrey">|~g' \
    | sed -e 's~¡~|</span>~g' \
    | sed -e 's/~/<span class="code_lightgrey">-/g' \
    | sed -e 's~-=~--</span>~g' \
    | sed -e 's~`~<span class="code_lightgrey"> ~g' \
    | sed -e 's~|[+]\([^|]*\)~|<span class="red_bg"> \1</span>~g' \
    | sed -e 's~|[$]\([^|]*\)~|<span class="green_bg"> \1</span>~g' \
    | sed -e 's~\^\([^^]*\)\^~<span class="yellow_bg"> \1 </span>~g' \
    | sed -e 's~ <= ~ \&lt;= ~g' \
    | sed -e 's~ < ~ \&lt; ~g' \
    | awk '{ if (NR == 1) printf("<pre data-type=\"programlisting\">\n"); } { print $0 } END { printf("</pre>\n") }' \
    | tee /tmp/sql-output.txt \
    | pbcopy
echo
echo
cat /tmp/sql-output.txt
echo
echo
