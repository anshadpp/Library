
package sample.user.dashboard.model;

import java.util.Base64;

public class ViewUUpload {
    private int id;
    private int userId;
    private String bookName;
    private String authorName;
    private byte[] pdfFile;
    private byte[] imageFile;
    private String description;
    private String category;
    private double price;

    // Parameterized constructor
    public ViewUUpload(int id, int userId, String bookName, String authorName, byte[] pdfFile, byte[] imageFile, String description,double price, String category) {
        this.id = id;
        this.userId = userId;
        this.bookName = bookName;
        this.authorName = authorName;
        this.pdfFile = pdfFile;
        this.imageFile = imageFile;
        this.description=description;
        this.category=category;
        this.price = price;
    }

    public ViewUUpload() {
		// TODO Auto-generated constructor stub
	}

	// Getter methods
    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public String getBookName() {
        return bookName;
    }

    public String getAuthorName() {
        return authorName;
    }
    public String getDescription() {
    	return description;
    }
    public String getCategory() {
    	return category;
    }
    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public byte[] getPdfFile() {
        return pdfFile;
    }

    public byte[] getImageFile() {
        return imageFile;
    }
    public void setImageFile(byte[] imageFile) {
        this.imageFile = imageFile;
    }
    // Method to get image file as Base64 string
    public String getImageFileAsBase64() {
        return Base64.getEncoder().encodeToString(this.imageFile);
    }

    // Method to get PDF file as Base64 string
    public String getPdfFileAsBase64() {
        return Base64.getEncoder().encodeToString(this.pdfFile);
    }


    // Setter methods
    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }
    public void setDescription(String description) {
    	this.description = description;
    }
    public void setCategory(String category) {
    	this.category = category;
    }


}