package application;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.Node;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.DatePicker;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import model.Membership;
import wrapper.WrapperMembership;

public class CreateMembershipFeeController {

	@FXML
	private TextField typeField;
	@FXML
	private TextField amountField;
	@FXML
	private DatePicker monthPicker;
	@FXML
	private Button createBtn;

	public static ObservableList<Membership> membershipData;
	public static TableView<Membership> membershipTableView;

	public void create(ActionEvent event) {
		String type = typeField.getText();
		String amount = amountField.getText();
		LocalDate month = monthPicker.getValue();
		if (type.isEmpty()) {
			AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "Enter the type(type) of service!");
		} else if (amount.isEmpty()) {
			AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "Enter the amount of membership fee");
		} else if (month == null) {
			AlertShow.showAlert(Alert.AlertType.ERROR, "Try again",
					"Choose the month for which the membership fee is created!");
		} else {
			if (WrapperMembership.create(ChildController.imbdOfChoosenChild, type,
					Integer.parseInt(amount), month)) {
				SimpleDateFormat dt = new SimpleDateFormat("MM/yyyy");
				String m = dt.format(Date.valueOf(month));
				AlertShow.showAlert(Alert.AlertType.INFORMATION, "Announcements", "You have created a membership fee for " + m);
				membershipData = WrapperMembership.getAll(ChildController.imbdOfChoosenChild);
				membershipTableView.setItems(membershipData);
				Node node = (Node) event.getSource();
				Stage s = (Stage) node.getScene().getWindow();
				s.close();
			} else {
				AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "Membership fee was not created!");
			}
		}
	}

}
