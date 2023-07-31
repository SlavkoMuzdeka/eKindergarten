package model;

public class Educator extends Person {

	public Educator() {
		super();
	}

	public Educator(String firstName, String lastName, String imbd, String dateOfBirth, String address) {
		super(firstName, lastName, imbd, dateOfBirth, address);
	}

	@Override
	public String toString() {
		return "Educator [getFirstName()=" + getFirstName() + ", getLastName()=" + getLastName() + ", getImbd()="
				+ getImbd() + ", getDateOfBirth()=" + getDateOfBirth() + ", getAddress()=" + getAddress()
				+ ", toString()=" + super.toString() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ "]";
	}
	
}
