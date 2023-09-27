<template>
  <div class="card col-sm-12">
    <div class="card-header">
      <div class="form-row col-md-12">
        <div class="form-group col-sm-10">
          <label>Sucursal</label>
          <multiselect
            @input="cambioSucursal"
            v-model="busqueda.sucursal"
            :options="sucursales"
            :close-on-select="true"
            :show-labels="false"
            label="descripcion"
            :allow-empty="false"
            placeholder=""
          >
          </multiselect>
        </div>
        <div class="form-group col-sm-2">
          <label>Cantidad</label>
          <input
            v-model="busqueda.cantidad"
            type="text"
            class="form-control form-control"
          />
        </div>
      </div>
    </div>
    <div v-if="carga == 'LISTO'" class="card-body">
      <label v-if="gestiones.length == 0">No se encontraron datos.</label>
      <div v-else class="overflow-auto col-md-12" style="max-height: 450px">
        <table class="table table-sm table-hover">
          <thead>
            <tr>
              <th scope="col">Id Gestion</th>
              <th scope="col">Usuario</th>
              <th scope="col">Serie</th>
              <th scope="col">Socio</th>
              <th scope="col">Estado</th>
              <th scope="col">Fecha</th>
              <th scope="col">Origen</th>
              <th scope="col">Destino</th>
              <th scope="col">-</th>
            </tr>
          </thead>
          <tbody>
            <Detalles
              v-for="gestion in gestiones"
              :key="gestion.id"
              :gestion="gestion"
            />
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import Detalles from "./suministros-transacciones-detalles.vue";
import Multiselect from "vue-multiselect";
import { errorsMixin } from "@/mixins/errors.js";

export default {
  props: ["sucursales"],
  components: {
    Detalles,
    Multiselect,
  },
  data() {
    return {
      busqueda: {
        sucursal: null,
        cantidad: 30,
      },
      gestiones: null,
      carga: null,
      series: null,
    };
  },
  methods: {
    cambioSucursal(sucursal) {
      this.gestiones = [];
      this.series = [];
      this.carga = true;
      axios
        .post("/suministros/transacciones/data", {
          sucursal_id: sucursal.id,
          cantidad: this.busqueda.cantidad,
        })
        .then((res) => {
          this.carga = false;
          this.carga = "LISTO";
          this.gestiones = res.data;
        })
        .catch((error) => {
          this.carga = false;
          this.carga = "LISTO";
          this.handleError(error);
        });
    },
  },
  mixins: [errorsMixin],

};
</script>
