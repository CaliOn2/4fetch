BEGIN {
  RS="{";
  FS="\":";
  ORS="'";
}

{
  if (substr($4, length($4)-2, 3)=="com") {
    backoffset=2;

    if (substr($5, length($5)-3, 4)=="time") {
      backoffset+=4;
    }
    if (substr($5, length($5)-7, 8)=="filename") {
      backoffset+=8;
    }
    print substr($5,2,length($5)-2-backoffset);
  }
}
