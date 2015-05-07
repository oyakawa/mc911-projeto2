class mteste
{
  public static void main(String[] args)
  {
    if (!false) {
      System.out.println(new teste().c(true, 3));
    } else {
      System.out.println(10 - 2);
    }
  }
}

class teste {
  int [] a;
  public int c(boolean x, int y) {
	a = new int[10];
	System.out.println(100);
	System.out.println(a.length);
	//System.out.println(a[1]);
	//System.out.println(a[2]);
    return 1;
  }
}
