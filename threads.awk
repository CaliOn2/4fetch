BEGIN {
  RS="{";
  FS="\"";
}

{
  if ($2=="no") {
    print substr($3,2,length($3)-2);
  }
}
