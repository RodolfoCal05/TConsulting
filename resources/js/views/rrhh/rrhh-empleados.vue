<template>
  <div>
    <div class="card">
      <div class="card-header">
        <button type="submit" class="btn btn-success" @click="guardar">
          <i class="fas fa-save"></i> Guardar
        </button>
        <button type="submit" class="btn btn-danger" @click="nuevo">
          <i class="fas fa-broom"></i> Nuevo Registro
        </button>
      </div>
      <div class="card-body">
        <div class="col-sm-12">
          <div class="form-row">
            <div class="form-group col-sm-3">
              <label>CUE</label>
              <input
                type="number"
                class="form-control"
                v-model="form.cue"
                readonly
              />
            </div>
            <div class="form-group col-sm-3">
              <label>Empresa</label>
              <input type="text" class="form-control" v-model="form.empresa.nombre" readonly />
            </div>
            <div class="form-group col-sm-3">
              <label>{{ estado }}</label>
              <input type="checkbox" v-model="form.activo" />
            </div>
          </div>
          <div class="form-row">
            <div class="form-group col-sm-3">
              <label>Primer Nombre</label>
              <input type="text" class="form-control" v-model="form.nombre1" />
            </div>
            <div class="form-group col-sm-3">
              <label>Segundo Nombre</label>
              <input type="text" class="form-control" v-model="form.nombre2" />
            </div>
            <div class="form-group col-sm-3">
              <label>Tercer Nombre</label>
              <input type="text" class="form-control" v-model="form.nombre3" />
            </div>
          </div>
          <div class="form-row">
            <div class="form-group col-sm-3">
              <label>Primer Apellido</label>
              <input
                type="text"
                class="form-control"
                v-model="form.apellido1"
              />
            </div>
            <div class="form-group col-sm-3">
              <label>Segundo Apellido</label>
              <input
                type="text"
                class="form-control"
                v-model="form.apellido2"
              />
            </div>
            <div class="form-group col-sm-3">
              <label>Tercer Apellido</label>
              <input
                type="text"
                class="form-control"
                v-model="form.apellido3"
              />
            </div>
          </div>
          <div class="form-row">
            <div class="form-group col-sm-3">
              <label>DPI</label>
              <input type="number" class="form-control" v-model="form.dpi" />
            </div>
            <div class="form-group col-sm-3">
              <label>Fecha Nacimiento</label>
              <input
                type="date"
                class="form-control"
                v-model="form.fecha_nacimiento"
              />
            </div>
            <div class="form-group col-sm-3">
              <label>Direccion</label>
              <input
                type="text"
                class="form-control"
                v-model="form.direccion"
              />
            </div>
          </div>
          <div class="form-row">
            <div class="form-group col-sm-3">
              <label>Celular</label>
              <input
                type="number"
                class="form-control"
                v-model="form.celular"
              />
            </div>
            <div class="form-group col-sm-3">
              <label>Telefono</label>
              <input
                type="number"
                class="form-control"
                v-model="form.telefono"
              />
            </div>
            <div class="form-group col-sm-3">
              <label>Estado Civil</label>
              <input
                type="text"
                class="form-control"
                v-model="form.estado_civil"
              />
            </div>
          </div>
          <div class="form-row">
            <div class="form-group col-sm-3">
              <label>Puesto</label>
              <multiselect
                v-model="form.puesto"
                :allow-empty="false"
                :options="puestos"
                :close-on-select="true"
                :show-labels="false"
                label="descripcion"
                placeholder=""
              ></multiselect>
            </div>
            <div class="form-group col-sm-3">
              <label>Sueldo</label>
              <multiselect
                v-model="form.sueldo"
                :allow-empty="false"
                :options="sueldos"
                :close-on-select="true"
                :show-labels="false"
                label="sueldo"
                placeholder=""
              ></multiselect>
            </div>
            <div v-if="form.cue != null" class="form-group col-sm-3">
              <label>Observacion Ascenso</label>
              <input type="text" class="form-control" v-model="form.observacion" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Multiselect from "vue-multiselect";
import { errorsMixin } from "@/mixins/errors.js";
import Swal from "sweetalert2";
export default {
  components: {
    Multiselect,
  },
  data() {
    return {
      form: {
        cue: null,
        empresa: {
          id: null,
          nombre: null,
        },
        nombre1: null,
        nombre2: null,
        nombre3: null,
        apellido1: null,
        apellido2: null,
        apellido3: null,
        dpi: null,
        fecha_nacimiento: null,
        direccion: null,
        celular: null,
        telefono: null,
        estado_civil: null,
        puesto: [],
        sueldo: [],
        activo: true,
        observacion: null,
      },
      puestos: [],
      sueldos: [],
    };
  },
  mounted() {
    const id = { opcion: "inicio" };
    axios
      .get(`/rrhh/empleados/${JSON.stringify(id)}/detail`)
      //.post("/rrhh/empleados/", {form: this.form})
      .then((res) => {
        this.puestos = res.data;
      })
      .catch((error) => this.handleError(error));
  },
  computed: {
    estado() {
      return this.form.activo ? "ACTIVO" : "INACTIVO";
    },
    cambioValores() {
      this.banderaObservacion;
    },
  },
  methods: {
    guardar() {
      const params = { form: this.form };
      axios
        .post("/rrhh/empleados", params)
        .then((res) => {
          this.form = res.data.form;
          this.showToast("Registro Agregado Correctamente", "success", 1600);
        })
        .catch((err) => {
          this.handleError(err);
        });
    },
    nuevo() {
      this.form = {
        cue: null,
        empresa: {
          id: null,
          nombre: null,
        },
        nombre1: null,
        nombre2: null,
        nombre3: null,
        apellido1: null,
        apellido2: null,
        apellido3: null,
        dpi: null,
        fecha_nacimiento: null,
        direccion: null,
        celular: null,
        telefono: null,
        estado_civil: null,
        puesto: [],
        sueldo: [],
        activo: true,
        observacion: null,
      };
    },
  },
  mixins: [errorsMixin],
};
</script>

<style>
</style>