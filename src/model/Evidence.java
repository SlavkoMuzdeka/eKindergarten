package model;

public class Evidence {

	private String date;
	private String time;
	
	public Evidence() {
		super();
	}

	public Evidence(String date, String time) {
		super();
		this.date = date;
		this.time = time;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	@Override
	public String toString() {
		return "Evidence [date=" + date + ", time=" + time + "]";
	}
}
