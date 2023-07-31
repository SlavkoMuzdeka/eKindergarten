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
import javafx.scene.control.TextInputDialog;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.Image;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;
import model.Group;
import wrapper.WrapperGroup;

public class eVrticController implements Initializable {

	@FXML
	private Button createGroupBtn;
	@FXML
	private Button deleteGroupBtn;
	@FXML
	private TextField findGroupField;

	@FXML
	public TableView<Group> groupsTableView;

	@FXML
	private TableColumn<Group, String> groupNameTableColumn;
	@FXML
	private TableColumn<Group, String> numberOfMembersTableColumn;

	private ObservableList<Group> groupsSearchList = FXCollections.observableArrayList();

	public static String groupName;

	public void createGroup(ActionEvent e) {
		TextInputDialog inputdialog = new TextInputDialog();
		inputdialog.setContentText("Group name: ");
		inputdialog.setHeaderText("Enter group name");
		inputdialog.showAndWait();
		if (inputdialog.getEditor().getText() != null && !inputdialog.getEditor().getText().equals("")) {
			if (WrapperGroup.create(inputdialog.getEditor().getText())) {
				AlertShow.showAlert(Alert.AlertType.INFORMATION, "Successful creation",
						"You have successfully created a new group called " + inputdialog.getEditor().getText());
				groupsSearchList = WrapperGroup.getAll();
				groupsTableView.setItems(groupsSearchList);
			} else {
				AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "The name of the group should be unique.");
			}
		}
	}

	public void deleteGroup(ActionEvent e) {
		if (groupsTableView.getSelectionModel().getSelectedItem() == null) {
			AlertShow.showAlert(Alert.AlertType.INFORMATION, "Announcements",
					"To delete a group, first select which group you want to delete. After that, wipe it.");
		} else {
			if (WrapperGroup.delete(groupsTableView.getSelectionModel().getSelectedItem().getName())) {
				AlertShow.showAlert(Alert.AlertType.INFORMATION, "Successful deletion",
						"You have successfully deleted a group called "
								+ groupsTableView.getSelectionModel().getSelectedItem().getName());
				groupsSearchList = WrapperGroup.getAll();
				groupsTableView.setItems(groupsSearchList);
			} else {
				AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "The group has not been deleted.");
			}
		}
	}

	@Override
	public void initialize(URL arg0, ResourceBundle arg1) {
		groupsSearchList = WrapperGroup.getAll();

		groupNameTableColumn.setCellValueFactory(new PropertyValueFactory<>("name"));
		numberOfMembersTableColumn.setCellValueFactory(new PropertyValueFactory<>("numberOfMembers"));

		groupsTableView.setItems(groupsSearchList);
		GroupController.groupsTableView = groupsTableView;
		GroupController.groupsSearchList = groupsSearchList;

		FilteredList<Group> filteredData = new FilteredList<>(groupsSearchList, b -> true);
		findGroupField.textProperty().addListener((observable, oldValue, newValue) -> {
			filteredData.setPredicate(group -> {
				if (newValue.isEmpty() || newValue.isBlank() || newValue == null) {
					return true;
				}
				String input = newValue.toLowerCase();
				if (group.getName().toLowerCase().indexOf(input) > -1) {
					return true;
				} else {
					return false;
				}
			});
		});
		SortedList<Group> sortedData = new SortedList<>(filteredData);
		sortedData.comparatorProperty().bind(groupsTableView.comparatorProperty());
		groupsTableView.setItems(sortedData);
	}

	public void mouseClicked(MouseEvent event) {
		if (event.getClickCount() == 2) {
			try {
				groupName = groupsTableView.getSelectionModel().getSelectedItem().getName();
				BorderPane borderPane = FXMLLoader.load(getClass().getResource("GroupForm.fxml"));
				Stage stage = new Stage();
				stage.setScene(new Scene(borderPane));
				Image image = new Image(new File(Main.ICONS).toURI().toString());
				stage.getIcons().add(image);
				stage.setTitle("eVrtic");
				stage.setResizable(false);
				stage.show();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}

}
