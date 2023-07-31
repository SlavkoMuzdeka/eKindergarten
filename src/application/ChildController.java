package application;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.Optional;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.collections.transformation.SortedList;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.ButtonType;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.Image;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import model.Child;
import wrapper.WrapperChild;

public class ChildController implements Initializable {

	@FXML
	private TextField findChildField;

	@FXML
	public TableView<Child> childrenTableView;

	@FXML
	private TableColumn<Child, String> firstNameTableColumn;
	@FXML
	private TableColumn<Child, String> lastNameTableColumn;
	@FXML
	private TableColumn<Child, String> imbdTableColumn;
	@FXML
	private TableColumn<Child, String> dateOfBirthTableColumn;
	@FXML
	private TableColumn<Child, String> addressTableColumn;
	@FXML
	private TableColumn<Child, String> weightTableColumn;
	@FXML
	private TableColumn<Child, String> heightTableColumn;

	private ObservableList<Child> childrenSearchList = FXCollections.observableArrayList();

	public static String imbdOfChoosenChild;

	@Override
	public void initialize(URL arg0, ResourceBundle arg1) {
		childrenSearchList = WrapperChild.getAll();

		firstNameTableColumn.setCellValueFactory(new PropertyValueFactory<>("firstName"));
		lastNameTableColumn.setCellValueFactory(new PropertyValueFactory<>("lastName"));
		imbdTableColumn.setCellValueFactory(new PropertyValueFactory<>("imbd"));
		dateOfBirthTableColumn.setCellValueFactory(new PropertyValueFactory<>("dateOfBirth"));
		addressTableColumn.setCellValueFactory(new PropertyValueFactory<>("address"));
		weightTableColumn.setCellValueFactory(new PropertyValueFactory<>("weight"));
		heightTableColumn.setCellValueFactory(new PropertyValueFactory<>("height"));

		childrenTableView.setItems(childrenSearchList);
		childrenTableView.setOnMouseClicked(mouseClicked);

		FilteredList<Child> filteredData = new FilteredList<>(childrenSearchList, b -> true);
		findChildField.textProperty().addListener((observable, oldValue, newValue) -> {
			filteredData.setPredicate(child -> {
				if (newValue.isEmpty() || newValue.isBlank() || newValue == null) {
					return true;
				}
				String unesenaRijec = newValue.toLowerCase();
				if (child.getFirstName().toLowerCase().indexOf(unesenaRijec) > -1) {
					return true;
				} else if (child.getLastName().toLowerCase().indexOf(unesenaRijec) > -1) {
					return true;
				} else if (child.getImbd().toLowerCase().indexOf(unesenaRijec) > -1) {
					return true;
				} else {
					return false;
				}
			});
		});
		SortedList<Child> sortedData = new SortedList<>(filteredData);
		sortedData.comparatorProperty().bind(childrenTableView.comparatorProperty());
		childrenTableView.setItems(sortedData);
	}

	EventHandler<MouseEvent> mouseClicked = new EventHandler<MouseEvent>() {
		@Override
		public void handle(MouseEvent arg0) {
			if (arg0.getClickCount() == 2) {
				try {
					Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
					alert.setTitle("Select an option");
					alert.setHeaderText("Do you want to review arrivals/departures or membership fees");
					ButtonType showArrivalsDepartures = new ButtonType("Review arrivals/departures");
					ButtonType showMemberships = new ButtonType("Review memberships");
					alert.getButtonTypes().setAll(showArrivalsDepartures, showMemberships);
					Optional<ButtonType> result = alert.showAndWait();
					imbdOfChoosenChild = childrenTableView.getSelectionModel().getSelectedItem().getImbd();
					Stage stage = new Stage();
					Image image = new Image(new File(Main.ICONS).toURI().toString());
					stage.getIcons().add(image);
					if (result.get() == showArrivalsDepartures) {
						AnchorPane anchorPane = FXMLLoader.load(getClass().getResource("ArrivalDepartureForm.fxml"));
						stage.setScene(new Scene(anchorPane));
						stage.setTitle("Information about the arrivals/departures of the child");
						stage.setResizable(false);
						stage.show();
					} else if (result.get() == showMemberships) {
						AnchorPane anchorPane = FXMLLoader.load(getClass().getResource("MembershipFeeForm.fxml"));
						stage.setScene(new Scene(anchorPane));
						stage.setTitle("Information about the child's membership fees");
						stage.setResizable(false);
						stage.show();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	};

}
