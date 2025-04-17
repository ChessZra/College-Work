//
// SimpleC test program #1
//
void main()
{
  int x;     // define x:
  cin >> x;  // input a value:
  
  int y;
  int z;
  y = 3^2;   // 3 squared:
  z = x-y;

  cout << "x: ";
  cout << x;
  cout << endl;

  cout << "y: ";
  cout << y;
  cout << endl;

  if (z < 0)
    cout << "z is negative";
  else
    cout << z;
 
  cout << endl;
}
