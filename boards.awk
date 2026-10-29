BEGIN {
  RS="{";
  FS="\"";
}

{
  if ($2=="board") {
    print $4;
  }
}
