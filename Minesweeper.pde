import de.bezier.guido.*;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
public int NUM_ROWS = 5;
public int NUM_COLS = 5;
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
    while(NUM_MINES < 6)
    {
        int randR = (int)(Math.random()*5);
        int randC = (int)(Math.random()*5);
        if(mines.contains(buttons[randR][randC])== false)
        {
            mines.add(buttons[randR][randC]);
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
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
    if(r <= 4 && r >= 0 && c >= 0&& c <= 4){
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
