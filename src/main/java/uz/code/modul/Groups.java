package uz.code.modul;

import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@Entity
public class Groups extends BaseModel {
    private String name;

    @ManyToOne
    private Modules modules;

    public Groups(String name, Modules modules) {
        this.name = name;
        this.modules = modules;
    }
}
