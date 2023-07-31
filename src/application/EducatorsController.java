package application;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.collections.transformation.SortedList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import model.Educator;
import wrapper.WrapperEducator;

public class EducatorsController implements Initializable {

	@FXML private TextField findEducatorField;
	
	@FXML public TableView<Educator> educatorsTableView;
	
	@FXML private TableColumn<Educator, String> firstNameTableColumn;
	@FXML private TableColumn<Educator, String> lastNameTableColumn;
	@FXML private TableColumn<Educator, String> imbdTableColumn;
	@FXML private TableColumn<Educator, String> dateOfBirthTableColumn;
	@FXML private TableColumn<Educator, String> addressTableColumn;
	
	private ObservableList<Educator> educatorsSearchList = FXCollections.observableArrayList();
	
	@Override
	public void initialize(URL arg0, ResourceBundle arg1) {
		educatorsSearchList = WrapperEducator.getAll();
		
		firstNameTableColumn.setCellValueFactory(new PropertyValueFactory<>("firstName"));
		lastNameTableColumn.setCellValueFactory(new PropertyValueFactory<>("lastName"));
		imbdTableColumn.setCellValueFactory(new PropertyValueFactory<>("imbd"));
		dateOfBirthTableColumn.setCellValueFactory(new PropertyValueFactory<>("dateOfBirth"));
		addressTableColumn.setCellValueFactory(new PropertyValueFactory<>("address"));
		
		educatorsTableView.setItems(educatorsSearchList);
		
		FilteredList<Educator> filteredData = new FilteredList<>(educatorsSearchList, b -> true);
		findEducatorField.textProperty().addListener((observable,oldValue,newValue) -> {
			filteredData.setPredicate(educator -> {
				if(newValue.isEmpty() || newValue.isBlank() || newValue == null) {
					return true;
				}
				String input = newValue.toLowerCase();
				if(educator.getFirstName().toLowerCase().indexOf(input) > -1) {
					return true;
				}else if(educator.getLastName().toLowerCase().indexOf(input) > -1) {
					return true;
				}else if(educator.getImbd().toLowerCase().indexOf(input) > -1) {
					return true;
				}else {
					return false;
				}
			});
		});
		SortedList<Educator> sortedData = new SortedList<>(filteredData);
		sortedData.comparatorProperty().bind(educatorsTableView.comparatorProperty());
		educatorsTableView.setItems(sortedData);
	}
	
}
