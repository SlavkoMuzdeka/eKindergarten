package model;

public abstract class Person {

	private String firstName;
	private String lastName;
	private String imbd;
	private String dateOfBirth;
	private String address;

	public Person() {
		super();
	}

	public Person(String firstName, String lastName, String imbd, String dateOfBirth, String address) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.imbd = imbd;
		this.dateOfBirth = dateOfBirth;
		this.address = address;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getImbd() {
		return imbd;
	}

	public void setImbd(String imbd) {
		this.imbd = imbd;
	}

	public String getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public String toString() {
		return "Person [firstName=" + firstName + ", lastName=" + lastName + ", imbd=" + imbd + ", dateOfBirth="
				+ dateOfBirth + ", address=" + address + "]";
	}

}
