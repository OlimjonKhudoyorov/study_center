package uz.code.modul;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Students extends BaseModel {
    private String name;

    @Transient
    private Double totalPayment;

    @OneToMany(mappedBy = "students", fetch = FetchType.EAGER)
    private List<Payments> payments;

    @ManyToOne
    private Groups groups;

    public Students(String name, Groups groups) {
        this.name = name;
        this.groups = groups;
    }

    public double getTotalPayment() {
        double total = 0.0;
        for (Payments payment : payments) {
            total += payment.getAmount();
        }
        return total;
    }
}
