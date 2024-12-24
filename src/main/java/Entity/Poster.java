package Entity;

public class Poster {
    private int id;
    private String name;
    private String mail;
    private String phone;
    private String imgUrl;
    private int userId; // Thêm userId vào đây


    public Poster(int id, String name, String mail, String phone, String imgUrl) {
        this.id = id;
        this.name = name;
        this.mail = mail;
        this.phone = phone;
        this.imgUrl = imgUrl;

    }

    public Poster(String name, String mail, String phone, String imageUrl, int userId) {
        this.name = name;
        this.mail = mail;
        this.phone = phone;
        this.imgUrl = imageUrl;
        this.userId = userId;

    }

    public Poster() {

    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getPhone() {
        return phone;
    }


    @Override
    public String toString() {
        return "Poster{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", mail='" + mail + '\'' +
                ", phone='" + phone + '\'' +
                ", imgUrl='" + imgUrl + '\'' +
                '}';
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public int getUserId() {
        return userId;

    }

    public void setUserId(int userId) {
        this.userId = userId;
    }


}
