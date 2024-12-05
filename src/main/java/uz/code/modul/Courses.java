package uz.code.modul;

import jakarta.persistence.Entity;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@Entity
public class Courses extends BaseModel{
    private String name;

    public Courses(String name) {
        this.name = name;
    }
}
