package uz.code.modul;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Payments extends BaseModel {
    private Double amount;

    @CreationTimestamp
    private LocalDateTime paymentDate;

    @ManyToOne
    private Students students;

    public Payments(Double amount, Students students) {
        this.amount = amount;
        this.students = students;
    }
}
