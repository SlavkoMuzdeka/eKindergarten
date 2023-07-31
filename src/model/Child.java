package model;

public class Child extends Person {

	private String height;
	private String weight;
	
	public Child() {
		super();
	}
	
	public Child(String firstName, String lastName, String imbd, String dateOfBirth, String address, String height, String weight) {
		super(firstName, lastName, imbd, dateOfBirth, address);
		this.height = height;
		this.weight = weight;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public String getWeight() {
		return weight;
	}

	public void setWeight(String weight) {
		this.weight = weight;
	}

	@Override
	public String toString() {
		return "Child [height=" + height + ", weight=" + weight + ", getFirstName()=" + getFirstName()
				+ ", getLastName()=" + getLastName() + ", getImbd()=" + getImbd() + ", getDateOfBirth()="
				+ getDateOfBirth() + ", getAddress()=" + getAddress() + ", toString()=" + super.toString()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + "]";
	}
	
}
