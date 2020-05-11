package flower;
//用户信息类
public class userBean {
	private String Name;
	private int ID;
	private String sex;
	private String address;
	
	public userBean(String name, int iD, String sex, String address) {
		super();
		Name = name;
		ID = iD;
		this.sex = sex;
		this.address = address;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public userBean() {
		// TODO Auto-generated constructor stub
	}
	
}
