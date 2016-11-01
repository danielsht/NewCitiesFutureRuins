class CellOrganism {
  Cell cells[][][];
  int maxHeight = 20;
  int zDim = 20;
  float horizontalModifier = 0.5;
  float verticalModifier = 1.5;
  
  float maxHorizontalMod = 2.5;
  float minHorizontalMod = 0.2;
  float minVerticalMod = 0.2;
  float maxVerticalMod = 1.5;
  
  int startingLevel = 6;
  boolean nextState[][][];
  ArrayList <CityCenter> centers;
  ArrayList <River> rivers;
  ArrayList <Road> roads;
  
  CellOrganism() {
  }
  CellOrganism(int xDim, int yDim) {
    cells = new Cell[xDim][yDim][zDim];
    nextState = new boolean[xDim][yDim][zDim];
    centers = new ArrayList <CityCenter>();
    rivers = new ArrayList <River>();
    roads = new ArrayList <Road>();
  }
  
  void update() {
    generateNextState();
    updateCurrentState();
  }
  
  void initGrid() {
    for (int i = 0; i < xDim; i++) {
      for (int j = 0; j < yDim; j++) {
        for (int k = 0; k < zDim; k++) {
          if (cells[i][j][k] == null) {
            cells[i][j][k] = new Cell(sizer, new PVector(200 + (i*sizer), 595-(k*sizer), -150+(j*sizer)));  
          }
        }
      }    
    }
  }

  void renderCells() {
    for (int i = 0; i < xDim; i++) {
      for (int j = 0; j < yDim; j++) {
        for (int k = 0; k < zDim; k++) {
          if(cells[i][j][k] != null) {
            if (k > maxHeight) {
              maxHeight = k;
            }
            cells[i][j][k].render();
          }
        }    
      }
    }
  }
  
  void generateCell(int i, int j, int k) {
    if (cells[i][j][k] == null) {
      cells[i][j][k] = new Cell(sizer, new PVector(200 + (i*sizer), 600-(sizer/3), -150+(j*sizer)));  
    }
    cells[i][j][k].life = true;
    cells[i][j][k].status = 3;
  }
  
  void killCell(int i, int j, int k) {
    if (cells[i][j][k] != null) {
      if (cells[i][j][k].status <= 0) {
        cells[i][j][k].life = false;
      } else {
        cells[i][j][k].decreaseStatus();
      }
    }
  }
  
  void generateNextState() {
    for (int i = 0; i < xDim; i++) {
      for (int j = 0; j < yDim; j++) {
        for (int k = 0; k < zDim; k++) {
          // neighbor check
          int livingNeighbors = 0;
          for (int nx = -1; nx < 2; nx++) {
            for (int ny = -1; ny < 2; ny++) {
              for (int nz = -1; nz < 2; nz++) {
                int neighborX = i + nx;
                int neighborY = j + ny;
                int neighborZ = k + nz;
                if ((neighborX >= 0 && neighborY >= 0 && neighborZ >= 0) && (neighborX < xDim && neighborY < yDim && neighborZ < zDim)) {
                  if(cells[neighborX][neighborY][neighborZ] != null && cells[neighborX][neighborY][neighborZ].life) {
                    livingNeighbors++;
                  }
                }
              }
            }
          }
          cells[i][j][k].alpha = map(livingNeighbors, 0, 8, 5, 250);
          float mod = startingLevel - ((k*verticalModifier)+abs((closestCenterDistance(cells[i][j][k])-k)*horizontalModifier));
          if (abs(closestRoadDistance(cells[i][j][k])) <= 2) {
            mod += 3;
          }
          if (abs(closestRiverDistance(cells[i][j][k])) <= 2) {
            mod += 3;
          }
          
          if ((livingNeighbors >= 3 && livingNeighbors <= mod)) {
            //if (livingNeighbors >= 3) {
            //  cells[i][j][k].status += 1;
            //}
            nextState[i][j][k] = true;
          } else {
            //if (livingNeighbors > 2 && cells[i][j][k].status < 0) {
            //  cells[i][j][k].status = 0;
            //}
            nextState[i][j][k] = false;
          }
        }
        
      }
    }  
  }
  
  void updateCurrentState() {
    for (int i = 0; i < xDim; i++) {
      for (int j = 0; j < yDim; j++) {
        for (int k = 0; k < zDim; k++) {
          if(nextState[i][j][k])
            generateCell(i, j, k);
          else
            killCell(i, j, k);
        }
      }
    }
  }
  
  CityCenter closestCenter(Cell cell) {
    float minDistance = 999999999;
    int minIndex = 0;
    if (centers.size() <= 0) {
      return null;
    }
    for (int i = 0; i < centers.size(); i++) {
      float distance = cell.location.dist(centers.get(i).location)/sizer;
      if (minDistance > distance) {
        minDistance = distance;
        minIndex = i;
      }
    }
    return centers.get(minIndex);
  }
  
  float closestCenterDistance(Cell cell) {
    if(centers.size() <= 0)
      return 0;
     CityCenter c = closestCenter(cell);
     return cell.location.dist(c.location)/sizer;
  }
  
  float closestRiverDistance(Cell cell) {
    float minDistance = 999999999;
    int minIndex = 0;
    if (rivers.size() <= 0) {
      return 0;
    }
    for (int i = 0; i < rivers.size(); i++) {
      float distance = cell.location.dist(rivers.get(i).location)/sizer;
      if (minDistance > distance) {
        minDistance = distance;
        minIndex = i;
      }
    }
    return minDistance;
  }
  
  float closestRoadDistance(Cell cell) {
    float minDistance = 999999999;
    int minIndex = 0;
    if (roads.size() <= 0) {
      return 0;
    }
    for (int i = 0; i < rivers.size(); i++) {
      float distance = cell.location.dist(roads.get(i).location)/sizer;
      if (minDistance > distance) {
        minDistance = distance;
        minIndex = i;
      }
    }
    return minDistance;
  }
  
  void createCenter(int x, int y) { 
    if ((x >= 0 && x < xDim) && (y >= 0 && y < yDim)) {
      centers.add(new CityCenter(x, y));
      populateBox(x, y, 0);
    }
  }
  
  void createRiver(int x, int y) { 
    if ((x >= 0 && x < xDim) && (y >= 0 && y < yDim)) {
      rivers.add(new River(x, y));
    }
  }
  
  void createRoad(int x, int y) { 
    if ((x >= 0 && x < xDim) && (y >= 0 && y < yDim)) {
      roads.add(new Road(x, y));
    }
  }
  
  void populateBox(int row, int col, int depth) {
    generateCell(row-1, col-1, depth);
    generateCell(row, col-1, depth);
    generateCell(row+1, col-1, depth);
    generateCell(row-1, col, depth);
    generateCell(row, col, depth);
    generateCell(row+1, col, depth);
  }
  
  void incrementHeight() {
    if (verticalModifier > minVerticalMod) {
      verticalModifier -= 0.05;
    }
  }
  
  void decrementHeight() {
    if (verticalModifier < maxVerticalMod) {
      verticalModifier += 0.05;
    }
  }
  
  void incrementDiameter() {
    if (horizontalModifier > minHorizontalMod) {
      horizontalModifier -= 0.1;
    }
  }
  void decrementDiameter() {
    if (horizontalModifier < maxHorizontalMod) {
      horizontalModifier += 0.1;
    }
  }
}