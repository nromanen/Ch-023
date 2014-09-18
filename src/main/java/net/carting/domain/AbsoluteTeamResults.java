package net.carting.domain;

public class AbsoluteTeamResults {
    private int teamId;
    private PointPlaces shkpPointPlace;
    private PointPlaces maneuverPointPlace;
    private PointPlaces absolutePointPlace;
    public int getTeamId() {
        return teamId;
    }
    public void setTeamId(int teamId) {
        this.teamId = teamId;
    }
    public PointPlaces getShkpPointPlace() {
        return shkpPointPlace;
    }
    public void setShkpPointPlace(PointPlaces shkpPointPlace) {
        this.shkpPointPlace = shkpPointPlace;
    }
    public PointPlaces getManeuverPointPlace() {
        return maneuverPointPlace;
    }
    public void setManeuverPointPlace(PointPlaces maneuverPointPlace) {
        this.maneuverPointPlace = maneuverPointPlace;
    }
    public PointPlaces getAbsolutePointPlace() {
        return absolutePointPlace;
    }
    public void setAbsolutePointPlace(PointPlaces absolutePointPlace) {
        this.absolutePointPlace = absolutePointPlace;
    }
    
    public void setShkpPlace(int place) {
        this.shkpPointPlace.place=place;
    }
    
    public void setManeuverPlace(int place) {
        this.maneuverPointPlace.place=place;
    }
    
    public void setAbsolutePlace(int place) {
        this.absolutePointPlace.place=place;
    }
    
    public void setShkpPoints(int points) {
        this.shkpPointPlace.points=points;
    }
    
    public void setManeuverPoints(int points) {
        this.maneuverPointPlace.points=points;
    }
    
    public void setAbsolutePoints(int points) {
        this.absolutePointPlace.points=points;
    }
    
    public int getShkpPoints() {
        return this.shkpPointPlace.points;
    }
    
    public int getManeuverpPoints() {
        return this.maneuverPointPlace.points;
    }
    
    public int getAbsolutePoints() {
        return this.absolutePointPlace.points;
    }
    
    public int getShkpPlace() {
        return this.shkpPointPlace.place;
    }
    
    public int getManeuverpPlace() {
        return this.maneuverPointPlace.place;
    }
    
    public int getAbsolutePlace() {
        return this.absolutePointPlace.place;
    }
    
    public AbsoluteTeamResults(){
        shkpPointPlace = new PointPlaces();
        maneuverPointPlace = new PointPlaces();
        absolutePointPlace = new PointPlaces();
    }
    
    public AbsoluteTeamResults(int teamId, PointPlaces shkpPointPlace,
            PointPlaces maneuverPointPlace, PointPlaces absolutePointPlace) {
        super();
        this.teamId = teamId;
        this.shkpPointPlace = shkpPointPlace;
        this.maneuverPointPlace = maneuverPointPlace;
        this.absolutePointPlace = absolutePointPlace;
    }
    @Override
    public String toString() {
        return "AbsoluteTeamResults [teamId=" + teamId + ", shkpPointPlace="
                + shkpPointPlace + ", maneuverPointPlace=" + maneuverPointPlace
                + ", absolutePointPlace=" + absolutePointPlace + "]";
    }

    public class PointPlaces {
        private int points;
        private int place;
        
        public PointPlaces(){}
        
        public int getPoints() {
            return this.points;
        }
        
        public void setPoints(int points) {
            this.points = points;
        }
        
        public int getPlace() {
            return this.place;
        }
        
        public void setPlace(int place) {
            this.place = place;
        }
        
        public String toString() {
            return "PointPlace:[Place="+place+", Points="+points+"]";
        }
    }
}
