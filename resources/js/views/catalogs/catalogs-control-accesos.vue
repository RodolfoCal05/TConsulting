<template>
  <div class="container">
    <div class="form-row">
      <div class="form-group col-sm-9">
        <multiselect
          v-model="user"
          :allow-empty="false"
          :options="users"
          :close-on-select="true"
          :show-labels="false"
          label="name"
          placeholder="Seleccione un usuario"
        ></multiselect>
      </div>
      <div class="form-group col-sm-3">
        <button
          :class="buttonClass()"
          @click="guardarSeries"
          :disabled="serie.length == 0 || saving"
        >
          Guardar
        </button>
      </div>
    </div>
    <div class="form-row" v-if="user">
      <div class="form-group col-sm-9">
        <multiselect
          v-model="sucursal"
          :allow-empty="false"
          :options="sucursales"
          :close-on-select="true"
          :show-labels="false"
          @input="buscarSeries"
          label="descripcion"
          placeholder="Seleccione una Sucursal"
          :disabled="saving"
        ></multiselect>
      </div>
    </div>
    <div class="form-row" v-if="sucursal">
      <div class="form-group col-sm-9">
        <multiselect
          v-model="serie"
          label="descripcion"
          track-by="id"
          placeholder="Elegir series"
          open-direction="bottom"
          :multiple="true"
          :options="series"
          :searchable="true"
          :internal-search="true"
          :clear-on-select="false"
          :close-on-select="false"
          :show-no-results="false"
          :hide-selected="true"
          :disabled="saving"
        ></multiselect>
      </div>
    </div>
  </div>
</template>

<script>
import Multiselect from "vue-multiselect";
import { errorsMixin } from "@/mixins/errors.js";

export default {
  props: ["users", "sucursales", "series"],
  components: {
    Multiselect,
  },
  data() {
    return {
      sucursal: null,
      serie: [],
      user: null,
      saving: false,
    };
  },
  methods: {
    buscarSeries(sucursal) {
      this.startTransaction();
      this.saving = true;

      const id = {
        opcion: "series",
        user_id: this.user.id,
        sucursal_id: sucursal.id,
      };

      axios
        .get(`/catalogs/control-accesos/${JSON.stringify(id)}/detail`)
        .then((response) => {
          this.serie = response.data;
          this.saving = false;
        })
        .catch((error) => {
          this.handleError(error);
        });
    },
    guardarSeries() {
      this.startTransaction();
      this.saving = true;

      axios
        .post("/catalogs/control-accesos/", {
          sucursal: this.sucursal.id,
          series: this.serie,
          id: this.user.id,
        })
        .then((response) => {
          this.saving = false;
          this.showToast("Series Agregadas Correctamente");
        })
        .catch((error) => {
          this.handleError(error);
        });
    },
  },
  mixins: [errorsMixin],
};
</script>

<style>
</style>
