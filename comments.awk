BEGIN {
  RS="{";
  FS=":";
  ORS="'";
}

{
  if (substr($6, length($6)-3, 3)=="com") {
    backoffset=3;


    if (substr($7, length($7)-4, 4)=="time") {
      backoffset+=4; 
    }
    if (substr($7, length($7)-8, 8)=="filename") {
      backoffset+=8;
    }
    print substr($7,2,length($7)-2-backoffset);
  }
}
