package uz.code.modul;

import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@Entity
public class Modules extends BaseModel {
    private String name;

    @ManyToOne
    private Courses courses;

    public Modules(String name, Courses courses) {
        this.name = name;
        this.courses = courses;
    }
}
