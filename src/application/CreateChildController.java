package application;

import java.net.URL;
import java.time.LocalDate;
import java.util.ResourceBundle;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.DatePicker;
import javafx.scene.control.SplitPane;
import javafx.scene.control.TextField;
import javafx.scene.control.SplitPane.Divider;
import wrapper.WrapperChild;

public class CreateChildController implements Initializable {

	@FXML
	private Button addChildBtn;
	@FXML
	private TextField firstNameField;
	@FXML
	private TextField lastNameField;
	@FXML
	private TextField imbdField;
	@FXML
	private TextField addressField;
	@FXML
	private TextField heightField;
	@FXML
	private TextField weightField;
	@FXML
	private DatePicker datePicker;
	@FXML
	private SplitPane splitPane1;

	public void add(ActionEvent e) {
		if (firstNameField.getText().isEmpty()) {
			AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "Enter child first name!");
		} else if (lastNameField.getText().isEmpty()) {
			AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "Enter child last name!");
		} else if (imbdField.getText().isEmpty()) {
			AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "Enter child imbd!");
		} else if (datePicker.getValue() == null) {
			AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "Enter child date of birth!");
		} else if (addressField.getText().isEmpty()) {
			AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "Enter child address!");
		} else if (heightField.getText().isEmpty()) {
			AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "Enter child height!");
		} else if (weightField.getText().isEmpty()) {
			AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "Enter child weight!");
		} else if (imbdField.getText().length() != 13) {
			AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "IMBD should have 13 digits!");
		} else if (!isAddressValid()) {
			AlertShow.showAlert(Alert.AlertType.ERROR, "Try again",
					"Enter the address in the form [number,street,city]!");
		} else {
			String firstName = firstNameField.getText();
			String lastName = lastNameField.getText();
			String imbd = imbdField.getText();

			String[] address = addressField.getText().split(",");
			Integer streetNumber = Integer.parseInt(address[0]);
			String streetName = address[1];
			String city = address[2];

			Integer height = Integer.parseInt(heightField.getText());
			Integer weight = Integer.parseInt(weightField.getText());
			LocalDate dateOfBirth = datePicker.getValue();

			if (!WrapperChild.create(firstName, lastName, imbd, streetNumber, streetName, city,
					height, weight, dateOfBirth)) {
				AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "Creating a child account failed!");
				resetFields();
			} else {
				AlertShow.showAlert(Alert.AlertType.INFORMATION, "Successful addition",
						"You successfully created a child account");
				resetFields();
			}
		}
	}

	private boolean isAddressValid() {
		String adresa = addressField.getText();
		String[] niz = adresa.split(",");
		if (niz.length != 3) {
			return false;
		}
		try {
			Integer.parseInt(niz[0]);
		} catch (NumberFormatException ex) {
			return false;
		}
		return true;
	}

	private void resetFields() {
		firstNameField.setText("");
		lastNameField.setText("");
		imbdField.setText("");
		addressField.setText("");
		heightField.setText("");
		weightField.setText("");
		datePicker.setValue(null);
	}

	@Override
	public void initialize(URL arg0, ResourceBundle arg1) {
		Divider divider = splitPane1.getDividers().get(0);
		divider.positionProperty().addListener(new ChangeListener<Number>() {
			@Override
			public void changed(ObservableValue<? extends Number> observable, Number oldvalue, Number newvalue) {
				divider.setPosition(0.23);
			}
		});
	}

}
