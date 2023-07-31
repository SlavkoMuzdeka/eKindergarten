package application;

import java.io.File;
import java.net.URL;
import java.util.ResourceBundle;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.SplitPane;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.SplitPane.Divider;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.Image;
import javafx.scene.input.MouseEvent;
import javafx.stage.Stage;
import model.Child;
import model.Group;
import model.Educator;
import wrapper.WrapperChild;
import wrapper.WrapperGroup;
import wrapper.WrapperEducator;

public class GroupController implements Initializable {

	@FXML
	private Label groupNameLabel;
	@FXML
	private Button deleteEducatorBtn;
	@FXML
	private Button addEducatorBtn;
	@FXML
	private Button deleteChildBtn;
	@FXML
	private Button addChildBtn;
	@FXML
	private SplitPane splitPane;

	@FXML
	private TableView<Educator> groupEducatorsTableView;
	private TableView<Educator> educatorsTableView;

	@FXML
	private TableColumn<Educator, String> firstNameTableColumn;
	@FXML
	private TableColumn<Educator, String> lastNameTableColumn;
	@FXML
	private TableColumn<Educator, String> imbdTableColumn;
	@FXML
	private TableColumn<Educator, String> dateOfBirthTableColumn;
	@FXML
	private TableColumn<Educator, String> addressTableColumn;

	private TableColumn<Educator, String> firstNameTableColumnV;
	private TableColumn<Educator, String> lastNameTableColumnV;
	private TableColumn<Educator, String> imbdTableColumnV;
	private TableColumn<Educator, String> dateOfBirthTableColumnV;
	private TableColumn<Educator, String> addressTableColumnV;

	@FXML
	private TableView<Child> groupChildrenTableView;
	private TableView<Child> childrenTableView;

	@FXML
	private TableColumn<Child, String> firstNameTableColumn1;
	@FXML
	private TableColumn<Child, String> lastNameTableColumn1;
	@FXML
	private TableColumn<Child, String> imbdTableColumn1;
	@FXML
	private TableColumn<Child, String> dateOfBirthTableColumn1;
	@FXML
	private TableColumn<Child, String> addressTableColumn1;
	@FXML
	private TableColumn<Child, String> weightTableColumn;
	@FXML
	private TableColumn<Child, String> heightTableColumn;

	private TableColumn<Child, String> firstNameTableColumnD;
	private TableColumn<Child, String> lastNameTableColumnD;
	private TableColumn<Child, String> imbdTableColumnD;
	private TableColumn<Child, String> dateOfBirthTableColumnD;
	private TableColumn<Child, String> addressTableColumnD;
	private TableColumn<Child, String> weightTableColumnD;
	private TableColumn<Child, String> heightTableColumnD;

	private ObservableList<Child> groupChildren = FXCollections.observableArrayList();
	private ObservableList<Child> children = FXCollections.observableArrayList();
	private ObservableList<Child> freeChildren;

	private ObservableList<Educator> groupEducators = FXCollections.observableArrayList();
	private ObservableList<Educator> educators = FXCollections.observableArrayList();
	private ObservableList<Educator> freeEducators;

	private Stage stage1;
	private Stage stage2;
	public static TableView<Group> groupsTableView;
	public static ObservableList<Group> groupsSearchList;

	@Override
	public void initialize(URL arg0, ResourceBundle arg1) {
		groupNameLabel.setText(eVrticController.groupName);
		groupEducators = WrapperGroup.getEducators(eVrticController.groupName);
		groupChildren = WrapperGroup.getChildren(eVrticController.groupName);

		firstNameTableColumn.setCellValueFactory(new PropertyValueFactory<>("firstName"));
		lastNameTableColumn.setCellValueFactory(new PropertyValueFactory<>("lastName"));
		imbdTableColumn.setCellValueFactory(new PropertyValueFactory<>("imbd"));
		dateOfBirthTableColumn.setCellValueFactory(new PropertyValueFactory<>("dateOfBirth"));
		addressTableColumn.setCellValueFactory(new PropertyValueFactory<>("address"));

		firstNameTableColumn1.setCellValueFactory(new PropertyValueFactory<>("firstName"));
		lastNameTableColumn1.setCellValueFactory(new PropertyValueFactory<>("lastName"));
		imbdTableColumn1.setCellValueFactory(new PropertyValueFactory<>("imbd"));
		dateOfBirthTableColumn1.setCellValueFactory(new PropertyValueFactory<>("dateOfBirth"));
		addressTableColumn1.setCellValueFactory(new PropertyValueFactory<>("address"));
		weightTableColumn.setCellValueFactory(new PropertyValueFactory<>("weight"));
		heightTableColumn.setCellValueFactory(new PropertyValueFactory<>("height"));

		groupEducatorsTableView.setItems(groupEducators);
		groupChildrenTableView.setItems(groupChildren);
		setDivider(splitPane.getDividers().get(0), 0.45);
	}

	public void deleteEducatorsFromGroup(ActionEvent e) {
		if (groupEducatorsTableView.getSelectionModel().getSelectedItem() == null) {
			AlertShow.showAlert(Alert.AlertType.INFORMATION, "Announcements",
					"To delete the educator from the group, first choose which educator you want to delete. After that, perform the delete operation.");
		} else {
			if (WrapperGroup.deleteFromGroup(groupEducatorsTableView.getSelectionModel().getSelectedItem().getImbd(),
					groupNameLabel.getText())) {
				AlertShow.showAlert(Alert.AlertType.INFORMATION, "Successful deletion",
						"You've successfully removed the educator from the group.");
				int selectedId = groupEducatorsTableView.getSelectionModel().getSelectedIndex();
				groupEducatorsTableView.getItems().remove(selectedId);
				groupsSearchList = WrapperGroup.getAll();
				groupsTableView.setItems(groupsSearchList);
			} else {
				AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "The educator was not removed from the group.");
			}
		}
	}

	public void addEducatorInGroup(ActionEvent e) {
		educators = WrapperEducator.getAll();
		freeEducators = FXCollections.observableArrayList();
		determineFreeEducators();

		firstNameTableColumnV = new TableColumn<>();
		firstNameTableColumnV.setText("First name");
		firstNameTableColumnV.setPrefWidth(100);

		lastNameTableColumnV = new TableColumn<>();
		lastNameTableColumnV.setText("Last name");
		lastNameTableColumnV.setPrefWidth(100);

		imbdTableColumnV = new TableColumn<>();
		imbdTableColumnV.setText("IMBD");
		imbdTableColumnV.setPrefWidth(100);

		dateOfBirthTableColumnV = new TableColumn<>();
		dateOfBirthTableColumnV.setText("Date of birth");
		dateOfBirthTableColumnV.setPrefWidth(100);

		addressTableColumnV = new TableColumn<>();
		addressTableColumnV.setText("Address");
		addressTableColumnV.setPrefWidth(180);

		firstNameTableColumnV.setCellValueFactory(new PropertyValueFactory<>("firstName"));
		lastNameTableColumnV.setCellValueFactory(new PropertyValueFactory<>("lastName"));
		imbdTableColumnV.setCellValueFactory(new PropertyValueFactory<>("imbd"));
		dateOfBirthTableColumnV.setCellValueFactory(new PropertyValueFactory<>("dateOfBirth"));
		addressTableColumnV.setCellValueFactory(new PropertyValueFactory<>("address"));

		educatorsTableView = new TableView<>();
		educatorsTableView.setPrefWidth(580);
		educatorsTableView.setPrefHeight(350);

		educatorsTableView.getColumns().add(firstNameTableColumnV);
		educatorsTableView.getColumns().add(lastNameTableColumnV);
		educatorsTableView.getColumns().add(imbdTableColumnV);
		educatorsTableView.getColumns().add(dateOfBirthTableColumnV);
		educatorsTableView.getColumns().add(addressTableColumnV);

		educatorsTableView.setOnMouseClicked(add1);
		educatorsTableView.setItems(freeEducators);

		stage1 = new Stage();
		stage1.setScene(new Scene(educatorsTableView));
		stage1.setTitle("Educators");
		Image image = new Image(new File(Main.ICONS).toURI().toString());
		stage1.getIcons().add(image);
		stage1.show();
	}

	private void determineFreeEducators() {
		for (Educator v1 : educators) {
			boolean t = true;
			for (Educator v2 : groupEducators) {
				if (v1.getImbd().equals(v2.getImbd())) {
					t = false;
				}
			}
			if (t) {
				freeEducators.add(v1);
			}
		}
	}

	public void deleteChildFromGroup(ActionEvent e) {
		if (groupChildrenTableView.getSelectionModel().getSelectedItem() == null) {
			AlertShow.showAlert(Alert.AlertType.INFORMATION, "Announcements",
					"To delete the child from the group, first choose which child you want to delete. After that, perform the delete operation.");
		} else {
			if (WrapperGroup.deleteFromGroup(groupChildrenTableView.getSelectionModel().getSelectedItem().getImbd(),
					groupNameLabel.getText())) {
				AlertShow.showAlert(Alert.AlertType.INFORMATION, "Successful deletion",
						"You've successfully removed the educator from the group.");
				int selectedId = groupChildrenTableView.getSelectionModel().getSelectedIndex();
				groupChildrenTableView.getItems().remove(selectedId);
				groupsSearchList = WrapperGroup.getAll();
				groupsTableView.setItems(groupsSearchList);
			} else {
				AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "The child was not removed from the group.");
			}
		}
	}

	public void addChildInGroup(ActionEvent e) {
		children = WrapperChild.getAll();
		freeChildren = FXCollections.observableArrayList();
		determineFreeChildren();

		firstNameTableColumnD = new TableColumn<>();
		firstNameTableColumnD.setText("First name");
		firstNameTableColumnD.setPrefWidth(100);

		lastNameTableColumnD = new TableColumn<>();
		lastNameTableColumnD.setText("Last name");
		lastNameTableColumnD.setPrefWidth(100);

		imbdTableColumnD = new TableColumn<>();
		imbdTableColumnD.setText("IMBD");
		imbdTableColumnD.setPrefWidth(100);

		dateOfBirthTableColumnD = new TableColumn<>();
		dateOfBirthTableColumnD.setText("Date of birth");
		dateOfBirthTableColumnD.setPrefWidth(100);

		addressTableColumnD = new TableColumn<>();
		addressTableColumnD.setText("Address");
		addressTableColumnD.setPrefWidth(150);

		weightTableColumnD = new TableColumn<>();
		weightTableColumnD.setText("Weight");
		weightTableColumnD.setPrefWidth(75);

		heightTableColumnD = new TableColumn<>();
		heightTableColumnD.setText("Height");
		heightTableColumnD.setPrefWidth(75);

		firstNameTableColumnD.setCellValueFactory(new PropertyValueFactory<>("firstName"));
		lastNameTableColumnD.setCellValueFactory(new PropertyValueFactory<>("lastName"));
		imbdTableColumnD.setCellValueFactory(new PropertyValueFactory<>("imbd"));
		dateOfBirthTableColumnD.setCellValueFactory(new PropertyValueFactory<>("dateOfBirth"));
		addressTableColumnD.setCellValueFactory(new PropertyValueFactory<>("address"));
		weightTableColumnD.setCellValueFactory(new PropertyValueFactory<>("weight"));
		heightTableColumnD.setCellValueFactory(new PropertyValueFactory<>("height"));

		childrenTableView = new TableView<>();
		childrenTableView.setPrefWidth(700);
		childrenTableView.setPrefHeight(350);

		childrenTableView.getColumns().add(firstNameTableColumnD);
		childrenTableView.getColumns().add(lastNameTableColumnD);
		childrenTableView.getColumns().add(imbdTableColumnD);
		childrenTableView.getColumns().add(addressTableColumnD);
		childrenTableView.getColumns().add(dateOfBirthTableColumnD);
		childrenTableView.getColumns().add(weightTableColumnD);
		childrenTableView.getColumns().add(heightTableColumnD);

		childrenTableView.setItems(freeChildren);
		childrenTableView.setOnMouseClicked(add2);

		stage2 = new Stage();
		stage2.setScene(new Scene(childrenTableView));
		stage2.setTitle("Children");
		Image image = new Image(new File(Main.ICONS).toURI().toString());
		stage2.getIcons().add(image);
		stage2.show();
	}

	private void determineFreeChildren() {
		for (Child d1 : children) {
			boolean t = true;
			for (Child d2 : groupChildren) {
				if (d1.getImbd().equals(d2.getImbd())) {
					t = false;
				}
			}
			if (t) {
				freeChildren.add(d1);
			}
		}
	}

	private void setDivider(Divider divider, Double value) {
		divider.positionProperty().addListener(new ChangeListener<Number>() {
			@Override
			public void changed(ObservableValue<? extends Number> observable, Number oldvalue, Number newvalue) {
				divider.setPosition(value);
			}
		});
	}

	EventHandler<MouseEvent> add1 = new EventHandler<MouseEvent>() {
		@Override
		public void handle(MouseEvent arg0) {
			if (arg0.getClickCount() == 2) {
				if (WrapperGroup.addInGroup(educatorsTableView.getSelectionModel().getSelectedItem().getImbd(),
						groupNameLabel.getText(), true)) {
					AlertShow.showAlert(Alert.AlertType.INFORMATION, "Successful addition",
							"You have successfully added an educator to the group");
					groupEducators = WrapperGroup.getEducators(groupNameLabel.getText());
					groupEducatorsTableView.setItems(groupEducators);
					int selectedId = educatorsTableView.getSelectionModel().getSelectedIndex();
					educatorsTableView.getItems().remove(selectedId);
					stage1.close();
					groupsSearchList = WrapperGroup.getAll();
					groupsTableView.setItems(groupsSearchList);
				} else {
					AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "The educator was not added to the group.");
				}
			}
		}

	};

	EventHandler<MouseEvent> add2 = new EventHandler<MouseEvent>() {
		@Override
		public void handle(MouseEvent arg0) {
			if (arg0.getClickCount() == 2) {
				if (WrapperGroup.addInGroup(childrenTableView.getSelectionModel().getSelectedItem().getImbd(),
						groupNameLabel.getText(), false)) {
					AlertShow.showAlert(Alert.AlertType.INFORMATION, "Successful addition",
							"You have successfully added a child to the group");
					groupChildren = WrapperGroup.getChildren(groupNameLabel.getText());
					groupChildrenTableView.setItems(groupChildren);

					int selectedId = childrenTableView.getSelectionModel().getSelectedIndex();
					childrenTableView.getItems().remove(selectedId);
					stage2.close();
					groupsSearchList = WrapperGroup.getAll();
					groupsTableView.setItems(groupsSearchList);
				} else {
					AlertShow.showAlert(Alert.AlertType.ERROR, "Try again",
							"The child was not added to the group.");
				}
			}
		}

	};

}
