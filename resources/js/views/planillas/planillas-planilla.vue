<template>
  <div>
    <div class="card">
      <div class="card-header">
        <button type="Submit" class="btn btn-primary" @click="CrearPlanilla">
          Crear Planilla
        </button>
        <button
          type="Submit"
          class="btn btn-success"
          @click="calcularPlanilla"
          v-if="planilla.length != 0"
        >
          Calcular Planilla
        </button>
        <button
          type="submit"
          class="btn btn-primary"
          data-toggle="modal"
          data-target="#modalLista"
          v-if="planillaEmpleados.length != 0"
        >
          <i class="fas fa-eye"></i> Planilla
        </button>
      </div>
      <div class="card-body">
        <div class="col-sm-12">
          <table class="table table-hover">
            <thead class="bg-primary">
              <tr>
                <th scope="col">Planilla ID</th>
                <th scope="col">Empresa</th>
                <th scope="col">Tipo</th>
                <th scope="col">Fecha Inicio</th>
                <th scope="col">Fecha Fin</th>
                <th scope="col">Estado</th>
              </tr>
            </thead>
            <tbody>
              <tr v-if="planilla.length != 0">
                <td>{{ planilla.id }}</td>
                <td>{{ planilla.empresa.nombre }}</td>
                <td>{{ planilla.tipo.descripcion }}</td>
                <td>{{ planilla.fecha_inicio }}</td>
                <td>{{ planilla.fecha_fin }}</td>
                <td>{{ planilla.estado }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      <div
        class="modal"
        :id="'modalLista'"
        tabindex="-1"
        aria-labelledby="exampleModalLabel"
        aria-hidden="true"
      >
        <div class="modal-dialog" style="max-width: 50%">
          <div class="modal-content">
            <div class="modal-header text-center">
              <h4>Datos Planilla Calculada</h4>
              <button
                type="button"
                class="close"
                data-dismiss="modal"
                aria-label="Close"
              >
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <table class="table table-hover">
                <thead class="bg-primary">
                  <tr>
                    <th scope="col">Nombre Completo</th>
                    <th scope="col">ID Planilla</th>
                    <th scope="col">Dias Laborados</th>
                    <th scope="col">Liquido</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="datos in planillaEmpleados" :key="datos.id">
                    <td>{{ datos.empleado.nombre_completo }}</td>
                    <td>{{ datos.planilla.id }}</td>
                    <td>{{ datos.dias_laborados }}</td>
                    <td>Q. {{ datos.liquido }}</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { errorsMixin } from "@/mixins/errors.js";
import Swal from "sweetalert2";
export default {
  data() {
    return {
      planilla: [],
      planillaEmpleados: [],
    };
  },
  mounted() {
    const datos = { opcion: "inicio" };
    var bandera = 0;
    axios
      .get(`/planillas/planilla/${JSON.stringify(datos)}/detail`)
      .then((response) => {
        console.log(response.data);
        this.planilla = response.data.planilla[0];
        this.planillaEmpleados = response.data.planillaEmpleados;
      })
      .catch((error) => this.HandleError(error));
  },
  methods: {
    CrearPlanilla() {
      const datos = { opcion: "inicio" };
      axios
        .post("/planillas/planilla", datos)
        .then((response) => {
          console.log(response.data);
          this.planilla = response.data[0];
          this.showToast("Planilla Creada Correctamente", "success", 1600);
        })
        .catch((error) => {
          if (error.response.data.status != 422) {
            Swal.fire({
              text: error.response.data.message,
              icon: "warning",
            });
          }
        });
    },
    calcularPlanilla() {
      const datos = {};
      axios
        .put("/planillas/planilla/" + this.planilla.id, {
          datos: this.planilla,
        })
        .then((response) => {
          console.log(response.data);
          this.planillaEmpleados = response.data;
          this.showToast("Planilla Creada Correctamente", "success", 1600);
        })
        .catch((error) => {
          if (error.response.data.status != 422) {
            Swal.fire({
              text: error.response.data.message,
              icon: "warning",
            });
          }
        });
    },
    cerrarModal() {
      $("#modalFamilia").modal("hide");
    },
  },
  mixins: [errorsMixin],
};
</script>

<style>
</style>