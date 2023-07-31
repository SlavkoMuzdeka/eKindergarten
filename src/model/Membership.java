package model;

public class Membership {

	private Integer id;
	private String type;
	private String amount;
	private Boolean isPaid;
	private String membershipForMonth;

	public Membership() {
		super();
	}

	public Membership(Integer id, String type, String amount, Boolean isPaid, String membershipForMonth) {
		super();
		this.id = id;
		this.type = type;
		this.amount = amount;
		this.isPaid = isPaid;
		this.membershipForMonth = membershipForMonth;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public Boolean getIsPaid() {
		return isPaid;
	}

	public void setIsPaid(Boolean isPaid) {
		this.isPaid = isPaid;
	}

	public String getMembershipForMonth() {
		return membershipForMonth;
	}

	public void setMembershipForMonth(String membershipForMonth) {
		this.membershipForMonth = membershipForMonth;
	}

	@Override
	public String toString() {
		return "Membership [id=" + id + ", type=" + type + ", amount=" + amount + ", isPaid=" + isPaid
				+ ", membershipForMonth=" + membershipForMonth + "]";
	}
}
