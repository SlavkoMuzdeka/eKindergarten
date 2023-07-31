package application;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.SplitPane;
import javafx.scene.image.Image;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;
import wrapper.WrapperEducator;

public class KindergartenController implements Initializable {

	@FXML
	private Button kindergartenBtn;
	@FXML
	private Button educatorsBtn;
	@FXML
	private Button childrenBtn;
	@FXML
	private Button addChildBtn;
	@FXML
	private Button logoutBtn;
	@FXML
	public Label usernameLabel;
	@FXML
	private BorderPane pane;
	@FXML
	private Button back;
	@FXML
	private Button createGroupBtn;

	public void viewHome(ActionEvent e) {
		try {
			BorderPane innerPane = FXMLLoader.load(getClass().getResource("eVrticForm.fxml"));
			pane.setCenter(innerPane);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
	}

	public void showEducators(ActionEvent e) {
		try {
			BorderPane borderPane = (BorderPane) FXMLLoader.load(getClass().getResource("EducatorsForm.fxml"));
			pane.setCenter(borderPane);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
	}

	public void showChildren(ActionEvent e) {
		try {
			BorderPane borderPane = (BorderPane) FXMLLoader.load(getClass().getResource("ChildrenForm.fxml"));
			pane.setCenter(borderPane);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
	}

	public void createChild(ActionEvent e) {
		try {
			SplitPane splitPane = FXMLLoader.load(getClass().getResource("CreateChildForm.fxml"));
			pane.setCenter(splitPane);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
	}

	public void showLoginForm(ActionEvent e) {
		try {
			FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("LoginForm.fxml"));
			Parent root1 = (Parent) fxmlLoader.load();
			Stage stage = new Stage();
			stage.setScene(new Scene(root1));
			Image image = new Image(new File(Main.ICONS).toURI().toString());
			stage.getIcons().add(image);
			stage.setTitle("eVrtic");
			stage.setResizable(false);
			Node node = (Node) e.getSource();
			Stage s = (Stage) node.getScene().getWindow();
			s.close();
			stage.show();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	@Override
	public void initialize(URL arg0, ResourceBundle arg1) {
		try {
			usernameLabel.setText(WrapperEducator.getName(LoginController.username, LoginController.password));
			BorderPane borderPane = FXMLLoader.load(getClass().getResource("eVrticForm.fxml"));
			pane.setCenter(borderPane);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

}
