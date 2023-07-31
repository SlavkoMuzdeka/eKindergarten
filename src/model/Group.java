package model;

public class Group {

	private String name;
	private Integer numberOfMembers;
	
	public Group() {
		super();
	}

	public Group(String name, Integer numberOfMembers) {
		super();
		this.name = name;
		this.numberOfMembers = numberOfMembers;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getNumberOfMembers() {
		return numberOfMembers;
	}

	public void setNumberOfMembers(Integer numberOfMembers) {
		this.numberOfMembers = numberOfMembers;
	}

	@Override
	public String toString() {
		return "Group [name=" + name + ", numberOfMembers=" + numberOfMembers + "]";
	}
}
