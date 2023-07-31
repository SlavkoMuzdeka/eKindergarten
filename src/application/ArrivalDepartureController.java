package application;

import java.net.URL;
import java.util.Optional;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.collections.transformation.SortedList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonType;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import model.Child;
import model.Evidence;
import wrapper.WrapperEvidence;

public class ArrivalDepartureController implements Initializable {

	@FXML
	private Button evidenceArrivalBtn;
	@FXML
	private Button evidenceDepartureBtn;
	@FXML
	private TextField findDateField;

	@FXML
	private TableView<Evidence> evidenceTableView;

	@FXML
	private TableColumn<Child, String> dateColumn;
	@FXML
	private TableColumn<Child, String> timeColumn;

	private ObservableList<Evidence> evidenceData = FXCollections.observableArrayList();

	@Override
	public void initialize(URL arg0, ResourceBundle arg1) {
		evidenceData = WrapperEvidence.getAll(ChildController.imbdOfChoosenChild);
		dateColumn.setCellValueFactory(new PropertyValueFactory<>("date"));
		timeColumn.setCellValueFactory(new PropertyValueFactory<>("time"));
		evidenceTableView.setItems(evidenceData);
		enableFiltering();
	}

	public void logArrivalTime(ActionEvent event) {
		boolean pom = showQuestions("arrival");
		if (pom) {
			if (WrapperEvidence.setArrival(ChildController.imbdOfChoosenChild)) {
				AlertShow.showAlert(Alert.AlertType.INFORMATION, "Successful logging",
						"You have successfully recorded the time of arrival.");
				if (!WrapperEvidence.isMembershipPaid) {
					AlertShow.showAlert(Alert.AlertType.INFORMATION, "Announcements", "No paid membership fees");
				}
				evidenceData = WrapperEvidence.getAll(ChildController.imbdOfChoosenChild);
				evidenceTableView.setItems(evidenceData);
				enableFiltering();
			} else {
				AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "Recording the time of arrival is not successful.");
			}
		}
	}

	public void logDepartureTime(ActionEvent event) {
		boolean pom = showQuestions("departure");
		if (pom) {
			if (WrapperEvidence.setDeparture(ChildController.imbdOfChoosenChild)) {
				AlertShow.showAlert(Alert.AlertType.INFORMATION, "Successful logging",
						"You have successfully recorded the time of departure.");
				evidenceData = WrapperEvidence.getAll(ChildController.imbdOfChoosenChild);
				evidenceTableView.setItems(evidenceData);
				enableFiltering();
			} else {
				AlertShow.showAlert(Alert.AlertType.ERROR, "Try again",
						"Recording the time of departure is not successful.");
			}
		}
	}

	private boolean showQuestions(String str) {
		Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
		alert.setTitle("Confirm logging operation");
		alert.setHeaderText("Do you want to record the time " + str + "?");
		ButtonType yesButton = new ButtonType("Yes");
		ButtonType noButton = new ButtonType("No");
		alert.getButtonTypes().setAll(yesButton, noButton);
		Optional<ButtonType> result = alert.showAndWait();
		if (result.get() == yesButton) {
			return true;
		} else {
			return false;
		}
	}

	private void enableFiltering() {
		FilteredList<Evidence> filteredData = new FilteredList<>(evidenceData, b -> true);
		findDateField.textProperty().addListener((observable, oldValue, newValue) -> {
			filteredData.setPredicate(ev -> {
				if (newValue.isEmpty() || newValue.isBlank() || newValue == null) {
					return true;
				}
				String input = newValue.toLowerCase();
				if (ev.getDate().toLowerCase().indexOf(input) > -1) {
					return true;
				} else {
					return false;
				}
			});
		});
		SortedList<Evidence> sortedData = new SortedList<>(filteredData);
		sortedData.comparatorProperty().bind(evidenceTableView.comparatorProperty());
		evidenceTableView.setItems(sortedData);
	}

}
