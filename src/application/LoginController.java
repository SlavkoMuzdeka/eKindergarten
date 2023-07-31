package application;

import java.io.File;
import java.io.IOException;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;
import wrapper.WrapperEducator;
import javafx.scene.Node;
import javafx.scene.Scene;

public class LoginController{
	
	@FXML private Button btnLogin;
	@FXML private TextField userNameField;
	@FXML private PasswordField passwordField;
	
	public static String username;
	public static String password;
	
	public void login(ActionEvent e) throws IOException {
		if(userNameField.getText().isEmpty()) {
			AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "Enter your username");
		}else if(passwordField.getText().isEmpty()) {
			AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "Enter password");
		}else {
			username = userNameField.getText();
			password = passwordField.getText();
			if(!WrapperEducator.isEducator(username,password)) {
				AlertShow.showAlert(Alert.AlertType.ERROR, "Try again", "Wrong username and/or password");
				userNameField.setText("");
				passwordField.setText("");
			}else {
				try {
					FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("KindergartenForm.fxml"));
					BorderPane root1 = (BorderPane) fxmlLoader.load();
					Stage stage = new Stage();
					stage.setScene(new Scene(root1));
					Image image = new Image(new File(Main.ICONS).toURI().toString());
					stage.getIcons().add(image);
					stage.setTitle("eVrtic");
					stage.setResizable(false);
					Node node = (Node)e.getSource();
					Stage s = (Stage) node.getScene().getWindow();
					s.close();
					stage.show();
				}catch(Exception ex) {
					ex.printStackTrace();
				}
			}
		}
	}
	
}
