package application;

import java.io.File;
import java.net.URL;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.collections.transformation.SortedList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.Image;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import model.Membership;
import wrapper.WrapperMembership;

public class MembershipController implements Initializable {

	@FXML
	private Button logPaymantBtn;
	@FXML
	private Button createMembershipFeeBtn;
	@FXML
	private TextField findMembershipFeeField;

	@FXML
	private TableView<Membership> membershipFeesTableView;

	@FXML
	private TableColumn<Membership, String> typeColumn;
	@FXML
	private TableColumn<Membership, String> amountColumn;
	@FXML
	private TableColumn<Membership, String> isPaidColumn;
	@FXML
	private TableColumn<Membership, String> monthColumn;

	private ObservableList<Membership> membershipFeesData = FXCollections.observableArrayList();

	@Override
	public void initialize(URL arg0, ResourceBundle arg1) {
		membershipFeesData = WrapperMembership.getAll(ChildController.imbdOfChoosenChild);

		typeColumn.setCellValueFactory(new PropertyValueFactory<>("type"));
		amountColumn.setCellValueFactory(new PropertyValueFactory<>("amount"));
		isPaidColumn.setCellValueFactory(new PropertyValueFactory<>("isPaid"));
		monthColumn.setCellValueFactory(new PropertyValueFactory<>("membershipForMonth"));

		membershipFeesTableView.setItems(membershipFeesData);
		enableFiltering();
	}

	private void enableFiltering() {
		FilteredList<Membership> filteredData = new FilteredList<>(membershipFeesData, b -> true);
		findMembershipFeeField.textProperty().addListener((observable, oldValue, newValue) -> {
			filteredData.setPredicate(ev -> {
				if (newValue.isEmpty() || newValue.isBlank() || newValue == null) {
					return true;
				}
				String input = newValue.toLowerCase();
				if (ev.getType().toLowerCase().indexOf(input) > -1) {
					return true;
				} else if (ev.getAmount().toLowerCase().indexOf(input) > -1) {
					return true;
				} else if (ev.getMembershipForMonth().toLowerCase().indexOf(input) > -1) {
					return true;
				} else {
					return false;
				}
			});
		});
		SortedList<Membership> sortedData = new SortedList<>(filteredData);
		sortedData.comparatorProperty().bind(membershipFeesTableView.comparatorProperty());
		membershipFeesTableView.setItems(sortedData);
	}

	public void createMembershipFee(ActionEvent e) {
		try {
			AnchorPane anchorPane = (AnchorPane) FXMLLoader
					.load(getClass().getResource("CreateMembershipFeeForm.fxml"));
			Stage stage = new Stage();
			stage.setScene(new Scene(anchorPane));
			Image image = new Image(new File(Main.ICONS).toURI().toString());
			stage.getIcons().add(image);
			stage.setTitle("eVrtic");
			stage.setResizable(false);
			stage.show();

			CreateMembershipFeeController.membershipData = membershipFeesData;
			CreateMembershipFeeController.membershipTableView = membershipFeesTableView;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public void logPaymant(ActionEvent e) {
		if (membershipFeesTableView.getSelectionModel().getSelectedItem() == null) {
			AlertShow.showAlert(Alert.AlertType.INFORMATION, "Announcements",
					"To record the payment of membership fees for a particular month, first choose a membership from the membership list!");
		} else {
			Membership membrship = membershipFeesTableView.getSelectionModel().getSelectedItem();
			if (membrship.getIsPaid()) {
				AlertShow.showAlert(Alert.AlertType.ERROR, "Error",
						"Membership fee is already paid for  " + membrship.getMembershipForMonth());
			} else {
				if (WrapperMembership.pay(Integer.valueOf(membrship.getId()))) {
					AlertShow.showAlert(Alert.AlertType.INFORMATION, "Announcements",
							"Membership fee is paid for " + membrship.getMembershipForMonth());
					membershipFeesData = WrapperMembership.getAll(ChildController.imbdOfChoosenChild);
					membershipFeesTableView.setItems(membershipFeesData);
					enableFiltering();
				} else {
					AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "Membership fee is not paid!");
				}
			}
		}
	}

}
