package sample.user.dashboard.model;
import java.util.Base64;

public class Books {
    private int id;
    private String bookName;
    private String username;
    private String authorName;
    private byte[] pdf_file_data;
    private byte[] image_data;
    private String description;
    private String category;
    private double price;

    public Books(int id,String username, String bookName, String authorName, String description, double price, String category) {
        this.id = id;
        this.category = category;
        this.bookName = bookName;
        this.username = username;
        this.authorName = authorName;
      
        this.description = description;
        this.price = price;
    }





	public int getId() {
        return id;
    }

    public String getBookName() {
        return bookName;
    }
    public String getusername() {
    	return username;
    }

    public String getAuthorName() {
        return authorName;
    }
    public String getCategory() {
    	return category;
    }
    public String getDescription() {
    	return description;
    }
    public byte[] getPdf_file_data() {
        return pdf_file_data;
    }
    public byte[] getImage_data() {
    	return image_data;
    }
    public double getPrice() {
        return price;
    }
    public String getImage_dataAsBase64() {
        return Base64.getEncoder().encodeToString(this.image_data);
    }

    public String getPdf_file__dataAsBase64() {
        return Base64.getEncoder().encodeToString(this.pdf_file_data);
    }
}
