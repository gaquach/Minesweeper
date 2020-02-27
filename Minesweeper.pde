import de.bezier.guido.*;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
public int NUM_ROWS = 20;
public int NUM_COLS = 20;
public int NUM_MINES = 0;
public void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );

    buttons = new MSButton[NUM_ROWS][NUM_COLS];                                                                   
    for(int r=0; r<NUM_ROWS; r++)
    {
        for(int c=0; c<NUM_COLS; c++)
        {
            buttons[r][c] = new MSButton(r,c);
        }
    }
    setMines();
}
public void setMines()
{
    while(NUM_MINES < 21)
    {
        int rR = (int)(Math.random()*20);
        int rC = (int)(Math.random()*20);
        if(mines.contains(buttons[rR][rC])== false)
        {
            mines.add(buttons[rR][rC]);
        }
        NUM_MINES++;
    }
}
public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for (int r=0;r<NUM_ROWS;r++)
    {
        for(int c=0;c<NUM_COLS;c++)
        {
            if(!mines.contains(buttons[r][c]) && buttons[r][c].isClicked() == false)
            {
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
    //your code here
    buttons[10][6].setLabel("Y");
    buttons[10][7].setLabel("O");
    buttons[10][8].setLabel("U");
    buttons[10][9].setLabel(" ");
    buttons[10][10].setLabel("L");
    buttons[10][11].setLabel("O");
    buttons[10][12].setLabel("S");
    buttons[10][13].setLabel("E");
}
public void displayWinningMessage()
{
    //your code here
    buttons[10][6].setLabel("Y");
    buttons[10][7].setLabel("O");
    buttons[10][8].setLabel("U");
    buttons[10][9].setLabel(" ");
    buttons[10][10].setLabel(" ");
    buttons[10][11].setLabel("W");
    buttons[10][12].setLabel("I");
    buttons[10][13].setLabel("N");
}
public boolean isValid(int r, int c)
{
    if(r <= 19 && r >= 0 && c >= 0&& c <= 19){
    return true;
    }
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if(isValid(row, col-1) && mines.contains(buttons[row][col-1]))
    {
        numMines++;
    }
    if(isValid(row, col-1) && mines.contains(buttons[row-1][col-1]))
    {
        numMines++;
    }
    if(isValid(row-1,col) && mines.contains(buttons[row-1][col]))
    {
        numMines++;
    }
     if(isValid(row+1, col-1) && mines.contains(buttons[row+1][col-1]))
    {
        numMines++;
    }
     if(isValid(row+1, col) && mines.contains(buttons[row+1][col]))
    {
        numMines++;
    }
     if(isValid(row,col+1) && mines.contains(buttons[row][col+1]))
    {
        numMines++;
    }
     if(isValid(row+1,col+1) && mines.contains(buttons[row+1][col+1]))
    {
        numMines++;
    }
     if(isValid(row-1,col+1) && mines.contains(buttons[row-1][col+1]))
    {
        numMines++;
    }
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isClicked(){
        return clicked;
    }
    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(mouseButton==LEFT)
        {
            clicked = true;
        }
        if(mouseButton==RIGHT)
        {
            flagged = !flagged;
        }
        else if(mines.contains(this))
        {
            displayLosingMessage();
        }
        else if(countMines(myRow,myCol)>0)  
        {
            setLabel(""+countMines(myRow,myCol));
        }
        else
        {
            if(isValid(myRow, myCol-1) && buttons[myRow][myCol-1].clicked == false){
                buttons[myRow][myCol-1].mousePressed();
            }                
            if(isValid(myRow-1, myCol-1) && buttons[myRow-1][myCol-1].clicked == false){
                buttons[myRow-1][myCol-1].mousePressed();
            }
            if(isValid(myRow-1, myCol) && buttons[myRow-1][myCol].clicked == false){
                buttons[myRow-1][myCol].mousePressed();
            }
            if(isValid(myRow-1, myCol+1) && buttons[myRow-1][myCol+1].clicked == false){
                buttons[myRow-1][myCol+1].mousePressed();
            }
            if(isValid(myRow, myCol+1) && buttons[myRow][myCol+1].clicked == false){
                buttons[myRow][myCol+1].mousePressed();
                }
            if(isValid(myRow+1, myCol+1) && buttons[myRow+1][myCol+1].clicked == false){
                buttons[myRow+1][myCol+1].mousePressed();
            }
            if(isValid(myRow+1, myCol) && buttons[myRow+1][myCol].clicked == false){
                buttons[myRow+1][myCol].mousePressed();
            }
            if(isValid(myRow+1, myCol-1) && buttons[myRow+1][myCol-1].clicked == false){
                buttons[myRow+1][myCol-1].mousePressed();
            }
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
