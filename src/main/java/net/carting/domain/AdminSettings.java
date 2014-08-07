package net.carting.domain;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Max;

@Entity
@Table(name = "admin_settings")
public class AdminSettings {

    @Id
    @Column(name = "id")
    @GeneratedValue
    private int id;

    @Column(name = "parental_permission_years", nullable = false)
    private int parentalPermissionYears;

 	

    @Max(1000)
    @Column(name = "points_by_places", nullable = false)
    private String pointsByPlaces;

    @Column(name = "feedback_email", nullable = false)
    private String feedbackEmail;
    
    public static final Map<Integer, String> POINTS_BY_TABLE_B;
    static {
    	POINTS_BY_TABLE_B = new HashMap<Integer, String>();
    	POINTS_BY_TABLE_B.put(2, "20,1");
    	POINTS_BY_TABLE_B.put(3, "30,14,1");
    	POINTS_BY_TABLE_B.put(4, "40,24,11,1");
    	POINTS_BY_TABLE_B.put(5, "50,34,21,10,1");
    	POINTS_BY_TABLE_B.put(6, "60,43,30,19,10,1");
    	POINTS_BY_TABLE_B.put(7, "70,53,39,28,18,9,1");
    	POINTS_BY_TABLE_B.put(8, "80,62,48,37,27,17,9,1");
    	POINTS_BY_TABLE_B.put(9, "90,72,57,46,35,25,17,9,1");
    	POINTS_BY_TABLE_B.put(10, "100,81,66,54,43,34,25,16,8,1");
    	POINTS_BY_TABLE_B.put(11, "100,82,69,57,47,38,30,22,15,8,1");
    	POINTS_BY_TABLE_B.put(12, "100,83,71,60,50,42,34,27,20,13,7,1");
    	POINTS_BY_TABLE_B.put(13, "100,84,72,62,53,45,37,31,24,18,12,6,1");
    	POINTS_BY_TABLE_B.put(14, "100,85,74,64,55,48,41,34,28,22,16,11,6,1");
    	POINTS_BY_TABLE_B.put(15, "100,86,75,66,57,50,43,37,31,25,20,15,10,6,1");
    	POINTS_BY_TABLE_B.put(16, "100,86,76,67,59,52,46,40,34,29,24,19,14,10,5,1");
    	POINTS_BY_TABLE_B.put(17, "100,87,77,68,61,54,48,42,37,31,27,22,17,13,9,5,1");
    	POINTS_BY_TABLE_B.put(18, "100,87,78,69,62,56,50,44,39,34,29,25,20,16,12,8,5,1");
    	POINTS_BY_TABLE_B.put(19, "100,88,78,71,64,57,51,46,41,36,32,27,23,19,15,12,8,4,1");
    	POINTS_BY_TABLE_B.put(20, "100,88,79,71,65,59,53,48,43,38,34,30,26,22,18,14,11,8,4,1");
    	POINTS_BY_TABLE_B.put(21, "100,89,80,72,66,60,55,49,45,40,36,32,28,24,21,17,14,10,7,4,1");
    	POINTS_BY_TABLE_B.put(22, "100,89,80,73,67,61,56,51,46,42,38,34,30,26,23,20,16,13,10,7,4,1");
    	POINTS_BY_TABLE_B.put(23, "100,89,81,74,68,62,57,52,48,44,40,36,32,28,25,22,19,15,12,9,7,4,1");
    	POINTS_BY_TABLE_B.put(24, "100,89,81,75,69,63,58,54,49,45,41,37,34,30,27,24,21,18,15,12,9,6,4,1");
    	POINTS_BY_TABLE_B.put(25, "100,90,82,75,69,64,59,55,51,46,43,39,36,32,29,26,23,20,17,14,11,9,6,4,1");
    	POINTS_BY_TABLE_B.put(26, "100,90,82,76,70,65,60,56,52,48,44,40,37,34,31,28,25,22,19,16,13,11,8,6,3,1");
    	POINTS_BY_TABLE_B.put(27, "100,90,83,76,71,66,61,57,53,49,45,42,39,35,32,29,26,23,21,18,15,13,10,8,6,3,1");
    	POINTS_BY_TABLE_B.put(28, "100,90,83,77,71,67,62,58,54,50,47,43,40,37,34,31,28,25,23,20,17,15,12,10,8,5,3,1");
    	POINTS_BY_TABLE_B.put(29, "100,91,83,77,72,67,63,59,55,51,48,44,41,38,35,32,29,27,24,22,19,17,14,12,10,7,5,3,1");
    	POINTS_BY_TABLE_B.put(30, "100,91,84,78,73,68,64,60,56,52,49,46,42,39,36,34,31,28,26,23,21,18,16,14,12,9,7,5,3,1");
    	POINTS_BY_TABLE_B.put(31, "100,91,84,78,73,69,64,60,57,53,50,47,44,41,38,35,32,30,27,25,22,20,18,15,13,11,9,7,5,3,1");
    	POINTS_BY_TABLE_B.put(32, "100,91,84,79,74,69,65,61,57,54,51,48,45,42,39,36,34,31,29,26,24,22,19,17,15,13,11,9,7,5,3,1");
    	POINTS_BY_TABLE_B.put(33, "100,91,85,79,74,70,66,62,58,55,52,49,46,43,40,37,35,32,30,28,25,23,21,19,17,14,12,10,8,7,5,3,1");
    	POINTS_BY_TABLE_B.put(34, "100,92,85,80,75,70,66,63,59,56,53,50,47,44,41,39,36,34,31,29,27,24,22,20,18,16,14,12,10,8,6,5,3,1");
    	POINTS_BY_TABLE_B.put(35, "100,92,85,80,75,71,67,63,60,56,53,50,48,45,42,40,37,35,32,30,28,26,24,21,19,17,15,14,12,10,8,6,4,3,1");	
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getParentalPermissionYears() {
        return parentalPermissionYears;
    }

    public void setParentalPermissionYears(int parentalPermissionYears) {
        this.parentalPermissionYears = parentalPermissionYears;
    }

    public String getPointsByPlaces() {
        return pointsByPlaces;
    }

    public void setPointsByPlaces(String pointsByPlaces) {
        this.pointsByPlaces = pointsByPlaces;
    }

    public String getFeedbackEmail() {
        return feedbackEmail;
    }

    public void setFeedbackEmail(String feedbackEmail) {
        this.feedbackEmail = feedbackEmail;
    }

}
