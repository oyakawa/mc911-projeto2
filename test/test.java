// testando operador + (OK)
class m309
{
  public static void main(String[] args)
  {
    if (!false) {
      System.out.println(10 * 2);
      System.out.println(10 + 3);
      System.out.println(10 * 4);
    } else {
      System.out.println(10 - 2);
    }
  }
}

class teste
{
  boolean a;
  int [] b;
  public boolean c(boolean x, int y)
  {
    System.out.println(10 * 3);
    return 1;
  }
  public boolean d()
  {
    //boolean e;
	int[] z;
	z = new int[2];
    //e = false;
	z[1] = 1;
	System.out.println(z[1]);
    return false;
  }
}

class feriado extends teste
{
	public boolean init()
	{
		System.out.println(2);
		return true;
	}
}
