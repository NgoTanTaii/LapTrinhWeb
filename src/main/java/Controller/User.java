package Controller;

public class User {
    private int id;
    private String username;
    private String email;
    private String role;
    private String password;
    private String status;
    private String token;



    public User(int id, String username, String email, String role, String password, String status, String token) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.role = role;
        this.password = password;
        this.status = status;
        this.token = token;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    public User() {

    }

    public User(String username, String email, String defaultPassword, String role, String status, String token) {
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    // Getters và setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getpassword() {
        return password;
    }

    public String getStatus() {
        return status;
    }
}
