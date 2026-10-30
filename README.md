# 4fetch
a 4chan random comment fetcher
(requires: curl bash awk and sed)

(known bugs: missing escape characters, comments starting with the double-dot(:) symbol return as empty)

(CRITICAL VULNERABILITY: At the current moment comments from 4chan can contain text that can be evaluated as bash script and thus result in rce)
