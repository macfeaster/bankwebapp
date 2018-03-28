package sg.edu.sutd.bank.webapp.model;

public class TransactionCode extends AbstractIdEntity {

	private String code;
	private User user;
	private boolean used;

	public TransactionCode() {}

	public TransactionCode(int id, String code, User user, boolean used) {
		this.id = id;
		this.code = code;
		this.user = user;
		this.used = used;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public boolean isUsed() {
		return used;
	}

	public void setUsed(boolean used) {
		this.used = used;
	}
}
