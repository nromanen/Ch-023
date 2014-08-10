package net.carting.domain;

import javax.persistence.*;

@Entity
@Table(name = "team_in_competition", uniqueConstraints = {@UniqueConstraint(columnNames = {
        "team_id", "competition_id"})})
public class TeamInCompetition {

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Id
    @Column(name = "id")
    @GeneratedValue
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "team_id", nullable = false)
    private Team team;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "competition_id", nullable = false)
    private Competition competition;

    public Team getTeam() {
        return team;
    }

    public void setTeam(Team team) {
        this.team = team;
    }

    public Competition getCompetition() {
        return competition;
    }

    public void setCompetition(Competition competition) {
        this.competition = competition;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result
                + ((competition == null) ? 0 : competition.hashCode());
        result = prime * result + ((team == null) ? 0 : team.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        TeamInCompetition other = (TeamInCompetition) obj;
        if (competition == null) {
            if (other.competition != null)
                return false;
        } else if (!competition.equals(other.competition))
            return false;
        if (team == null) {
            if (other.team != null)
                return false;
        } else if (!team.equals(other.team))
            return false;
        return true;
    }

    public TeamInCompetition() {
    }

    public TeamInCompetition(Team team, Competition competition) {
        this.team = team;
        this.competition = competition;
    }
}