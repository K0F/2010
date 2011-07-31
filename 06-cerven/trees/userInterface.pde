void mouseClicked(){
  fadeScreen();
  newTrees();
  for(int i=0; i<nTrees; i++)
    trees[i].draw();
}

void keyTyped(){
  if(key=='=' || key=='+'){
    nTrees++;
    newTrees();
  }
  if(key=='-' || key=='_'){
    if(nTrees>1)
    {
      nTrees--;
      newTrees();
    }
  }
  if(key=='s'){
    addSnow = !addSnow;
  }
  if(key==' '){
    blankScreen();
  }
}
