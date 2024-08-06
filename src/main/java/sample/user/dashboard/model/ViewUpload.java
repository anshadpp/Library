package sample.user.dashboard.model;

import java.io.InputStream;
import java.util.Base64;

public class ViewUpload {
    private int id;
    private int userId;
    private String bookName;
    private String authorName;
    private InputStream pdfInputStream;
    private InputStream imageInputStream;
    private String description;
    private String category;
    private double price;

    // Parameterized constructor
    public ViewUpload(int id, int userId, String bookName, String authorName, InputStream pdfInputStream, InputStream imageInputStream, String description, double price, String category) {
        this.id=id;
        this.userId = userId;
        this.bookName = bookName;
        this.authorName = authorName;
        this.pdfInputStream = pdfInputStream;
        this.imageInputStream = imageInputStream;
        this.description = description;
        this.category = category;
        this.price = price;
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

    public InputStream getPdfInputStream() {
        return pdfInputStream;
    }

    public InputStream getImageInputStream() {
        return imageInputStream;
    }

    // Methods to get image file and PDF file as Base64 strings
    public String getImageFileAsBase64() {
        if (imageInputStream != null) {
            try {
                byte[] bytes = imageInputStream.readAllBytes();
                return Base64.getEncoder().encodeToString(bytes);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public String getPdfFileAsBase64() {
        if (pdfInputStream != null) {
            try {
                byte[] bytes = pdfInputStream.readAllBytes();
                return Base64.getEncoder().encodeToString(bytes);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
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

    public void setPrice(double price) {
        this.price = price;
    }

    public void setPdfInputStream(InputStream pdfInputStream) {
        this.pdfInputStream = pdfInputStream;
    }

    public void setImageInputStream(InputStream imageInputStream) {
        this.imageInputStream = imageInputStream;
    }
}
