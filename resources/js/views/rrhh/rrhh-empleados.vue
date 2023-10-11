<template>
  <div>
    <div class="card">
      <div class="card-header">
        <button
          type="submit"
          class="btn btn-success"
          v-if="listaEmpleados.length == 0"
          @click="guardar"
        >
          <i class="fas fa-save"></i> Guardar
        </button>
        <button
          type="submit"
          class="btn btn-success"
          data-toggle="modal"
          data-target="#modalFamilia"
          @click="mostrarBtnMas(true)"
          v-if="listaEmpleados.length == 0"
        >
          <i class="fas fa-edit"></i>
          Agregar Familia
        </button>
        <button type="submit" class="btn btn-danger" @click="nuevo">
          <i class="fas fa-broom"></i> Nuevo Registro
        </button>
        <button type="submit" class="btn btn-primary" @click="buscarEmpleados">
          Lista Empleados
        </button>
      </div>
      <div class="card-body">
        <div class="col-sm-12" v-if="listaEmpleados.length != 0">
          <table class="table table-hover">
            <thead class="bg-primary">
              <tr>
                <th scope="col">Editar</th>
                <th scope="col">cue</th>
                <th scope="col">Nombre Completo</th>
                <th scope="col">DPI</th>
                <th scope="col">Genero</th>
                <th scope="col">Estado Civil</th>
                <th scope="col">Direccion</th>
                <th scope="col">Celular</th>
                <th scope="col">Puesto</th>
                <th scope="col">Sueldo</th>
                <th scope="col">Estado</th>
                <th scope="col">Ver Familia</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="datos in listaEmpleados" :key="datos.cue">
                <td>
                  <button
                    type="submit"
                    class="btn btn-primary btn-sm"
                    @click="editarEmpleado(datos)"
                  >
                    <i class="fas fa-edit"></i>
                  </button>
                </td>
                <td>{{ datos.cue }}</td>
                <td>{{ datos.nombre_completo }}</td>
                <td>
                  {{ datos.dpi }}
                </td>
                <td>
                  {{ datos.genero.descripcion }}
                </td>
                <td>{{ datos.estado_civil.descripcion }}</td>
                <td>{{ datos.direccion }}</td>
                <td>{{ datos.celular }}</td>
                <td>{{ datos.puesto.descripcion }}</td>
                <td>{{ datos.sueldo.sueldo }}</td>
                <td>{{ estadoEmpleado(datos.activo) }}</td>
                <td>
                  <button
                    type="submit"
                    class="btn btn-primary"
                    data-toggle="modal"
                    data-target="#modalFamilia"
                    @click="datosFamiliares(datos.familias)"
                  >
                    <i class="fas fa-eye"></i>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <div class="col-sm-12" v-if="listaEmpleados.length == 0">
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
              <multiselect
                v-model="form.empresa"
                :allow-empty="false"
                :options="empresas"
                :close-on-select="true"
                :show-labels="false"
                label="nombre"
                placeholder=""
              ></multiselect>
              <small class="text-danger" v-if="validationErrors['form.empresa']"
                >Empresa requerida
              </small>
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
              <small class="text-danger" v-if="validationErrors['form.nombre1']"
                >Primer Nombre requerido
              </small>
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
              <small
                class="text-danger"
                v-if="validationErrors['form.apellido1']"
                >Primer Apellido requerido
              </small>
            </div>
            <div class="form-group col-sm-3">
              <label>Segundo Apellido</label>
              <input
                type="text"
                class="form-control"
                v-model="form.apellido2"
              />
              <small
                class="text-danger"
                v-if="validationErrors['form.apellido2']"
                >Segundo apellido requerido
              </small>
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
              <small class="text-danger" v-if="validationErrors['form.dpi']"
                >DPI requerido
              </small>
            </div>
            <div class="form-group col-sm-3">
              <label>Fecha Nacimiento</label>
              <input
                type="date"
                class="form-control"
                v-model="form.fecha_nacimiento"
              />
              <small
                class="text-danger"
                v-if="validationErrors['form.fecha_nacimiento']"
                >Fecha Nacimiento requerido
              </small>
            </div>
            <div class="form-group col-sm-3">
              <label>Direccion</label>
              <input
                type="text"
                class="form-control"
                v-model="form.direccion"
              />
              <small
                class="text-danger"
                v-if="validationErrors['form.direccion']"
                >Direccion requerida
              </small>
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
              <small class="text-danger" v-if="validationErrors['form.celular']"
                >Celular requerido
              </small>
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
              <label>Genero</label>
              <multiselect
                v-model="form.genero"
                :allow-empty="false"
                :options="generos"
                :close-on-select="true"
                :show-labels="false"
                label="descripcion"
                placeholder=""
              ></multiselect>
              <small class="text-danger" v-if="validationErrors['form.genero']"
                >Genero requerido
              </small>
            </div>
          </div>
          <div class="form-row">
            <div class="form-group col-sm-3">
              <label>Estado Civil</label>
              <multiselect
                v-model="form.estado_civil"
                :allow-empty="false"
                :options="estadosCivil"
                :close-on-select="true"
                :show-labels="false"
                label="descripcion"
                placeholder=""
              ></multiselect>
              <small
                class="text-danger"
                v-if="validationErrors['form.estado_civil']"
                >Estado Civil requerido
              </small>
            </div>
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
                @input="buscarSueldos(form.puesto)"
              ></multiselect>
              <small class="text-danger" v-if="validationErrors['form.puesto']"
                >Puesto requerido
              </small>
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
              <small class="text-danger" v-if="validationErrors['form.sueldo']"
                >Sueldo requerido
              </small>
            </div>
          </div>
          <div class="form-row">
            <div class="form-group col-sm-3">
              <label>Correo</label>
              <input type="text" class="form-control" v-model="form.correo" />
            </div>
            <div v-if="form.cue != null" class="form-group col-sm-3">
              <label>Observacion Ascenso</label>
              <input
                type="text"
                class="form-control"
                placeholder="llenar si es ascenso"
                v-model="form.observacion"
              />
            </div>
          </div>
        </div>
      </div>
      <div
        class="modal"
        :id="'modalFamilia'"
        tabindex="-1"
        aria-labelledby="exampleModalLabel"
        aria-hidden="true"
      >
        <div class="modal-dialog" style="max-width: 50%">
          <div class="modal-content">
            <div class="modal-header text-center">
              <h4>Datos Familia</h4>
              <button
                type="submit"
                class="btn btn-success btn-sm ml-3"
                @click="nuevoFamiliar(true)"
                v-if="banderaBtnFamilia == true"
              >
                <i class="fas fa-user-plus"></i> Nuevo
              </button>
              <button
                type="button"
                class="close"
                data-dismiss="modal"
                aria-label="Close"
                @click="clearFormFamilia"
              >
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <table class="table table-hover">
                <thead class="bg-primary">
                  <tr>
                    <th scope="col">Nombre Completo</th>
                    <th scope="col">DPI</th>
                    <th scope="col">Genero</th>
                    <th scope="col">Celular</th>
                    <th scope="col">Estado Civil</th>
                    <th scope="col">Direccion</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="datos in form.familias" :key="datos.id">
                    <td>
                      {{
                        nombreC(
                          datos.nombre1,
                          datos.nombre2,
                          datos.nombre3,
                          datos.apellido1,
                          datos.apellido2,
                          datos.apellido3
                        )
                      }}
                    </td>
                    <td>
                      {{ datos.dpi }}
                    </td>
                    <td>
                      {{ datos.genero.descripcion }}
                    </td>
                    <td>{{ datos.celular }}</td>
                    <td>{{ datos.estado_civil.descripcion }}</td>
                    <td>{{ datos.direccion }}</td>
                  </tr>
                </tbody>
              </table>
              <div
                v-if="
                  banderaFamiliar == true && this.listaEmpleados.length == 0
                "
              >
                <div class="form-group">
                  <label>Primer Nombre</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="formFamilia.nombre1"
                  />
                </div>
                <div class="form-group">
                  <label>Segundo Nombre</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="formFamilia.nombre2"
                  />
                </div>
                <div class="form-group">
                  <label>Tercer Nombre</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="formFamilia.nombre3"
                  />
                </div>
                <div class="form-group">
                  <label>Primer Apellido</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="formFamilia.apellido1"
                  />
                </div>
                <div class="form-group">
                  <label>Segundo Apellido</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="formFamilia.apellido2"
                  />
                </div>
                <div class="form-group">
                  <label>Tercer Apellido</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="formFamilia.apellido3"
                  />
                </div>
                <div class="form-group">
                  <label>DPI</label>
                  <input
                    type="number"
                    class="form-control"
                    v-model="formFamilia.dpi"
                  />
                </div>
                <div class="form-group">
                  <label>Fecha Nacimiento</label>
                  <input
                    type="date"
                    class="form-control"
                    v-model="formFamilia.fecha_nacimiento"
                  />
                </div>
                <div class="form-group">
                  <label>Direccion</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="formFamilia.direccion"
                  />
                </div>
                <div class="form-group">
                  <label>Celular</label>
                  <input
                    type="number"
                    class="form-control"
                    v-model="formFamilia.celular"
                  />
                </div>
                <div class="form-group">
                  <label>Telefono</label>
                  <input
                    type="number"
                    class="form-control"
                    v-model="formFamilia.telefono"
                  />
                </div>
                <div class="form-group">
                  <label>Genero</label>
                  <multiselect
                    v-model="formFamilia.genero"
                    :allow-empty="false"
                    :options="generos"
                    :close-on-select="true"
                    :show-labels="false"
                    label="descripcion"
                    placeholder=""
                  ></multiselect>
                </div>
                <div class="form-group">
                  <label>Estado Civil</label>
                  <multiselect
                    v-model="formFamilia.estado_civil"
                    :allow-empty="false"
                    :options="estadosCivil"
                    :close-on-select="true"
                    :show-labels="false"
                    label="descripcion"
                    placeholder=""
                  ></multiselect>
                </div>
                <div class="form-group">
                  <label>Tipo Familia</label>
                  <multiselect
                    v-model="formFamilia.tipo_familia"
                    :allow-empty="false"
                    :options="tipoFamilias"
                    :close-on-select="true"
                    :show-labels="false"
                    label="descripcion"
                    placeholder=""
                  ></multiselect>
                </div>
                <div class="modal-footer text-center">
                  <button
                    class="btn btn-danger"
                    data-dismiss="modal"
                    @click="clearFormFamilia"
                  >
                    Cancelar
                  </button>
                  <button class="btn btn-success" @click="agregarFamilia">
                    Agregar
                  </button>
                </div>
              </div>
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
        nombre1: null,
        nombre2: null,
        nombre3: null,
        apellido1: null,
        apellido2: null,
        apellido3: null,
        dpi: null,
        genero: [],
        fecha_nacimiento: null,
        direccion: null,
        celular: null,
        telefono: null,
        estado_civil: [],
        puesto: [],
        sueldo: [],
        correo: null,
        activo: true,
        observacion: null,
        familias: [],
        empresa: [],
      },
      formFamilia: {
        id: null,
        nombre1: null,
        nombre2: null,
        nombre3: null,
        apellido1: null,
        apellido2: null,
        apellido3: null,
        dpi: null,
        genero: [],
        fecha_nacimiento: null,
        direccion: null,
        celular: null,
        telefono: null,
        estado_civil: [],
        correo: null,
        tipo_familia: [],
      },
      banderaBtnFamilia: false,
      banderaFamiliar: false,
      puestos: [],
      sueldos: [],
      tipoFamilias: [],
      empresas: [],
      estadosCivil: [],
      generos: [],
      listaEmpleados: [],
      validationErrors: {
        form: null,
      },
    };
  },
  mounted() {
    const datos = { opcion: "inicio" };
    axios
      .get(`/rrhh/empleados/${JSON.stringify(datos)}/detail`)
      //.post("/rrhh/empleados/", {form: this.form})
      .then((res) => {
        this.puestos = res.data.puestos;
        this.tipoFamilias = res.data.tipoFamilias;
        this.empresas = res.data.empresas;
        this.estadosCivil = res.data.estadosCivil;
        this.generos = res.data.generos;
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
      axios
        .post("/rrhh/empleados", { form: this.form })
        .then((res) => {
          console.log(res.data);
          this.form = res.data[0];
          this.showToast("Registro Agregado Correctamente", "success", 1600);
          this.validationErrors = { form: null };
        })
        .catch((err) => {
          this.handleError(err);
        });
    },
    buscarSueldos(puesto) {
      const datos = { id: puesto.id, opcion: "sueldos" };
      axios
        .get(`/rrhh/empleados/${JSON.stringify(datos)}/detail`)
        .then((res) => {
          this.sueldos = res.data;
        })
        .catch((err) => this.handleError(err));
    },
    mostrarBtnMas(valor) {
      this.banderaBtnFamilia = valor;
    },
    nuevoFamiliar(valor) {
      this.banderaFamiliar = valor;
    },
    agregarFamilia() {
      let validaciones = {
        Primer_Nombre: this.formFamilia.nombre1,
        Primer_Apellido: this.formFamilia.apellido1,
        Segundo_Apellido: this.formFamilia.apellido2,
        Fecha_Nacimiento: this.formFamilia.fecha_nacimiento,
        Genero: this.formFamilia.genero,
        Estado_Civil: this.formFamilia.estado_civil,
        Tipo_Familia: this.formFamilia.tipo_familia,
      };

      for (let clave in validaciones) {
        let valor = validaciones[clave];
        if (valor === null || valor === "" || valor.length === 0) {
          this.showToast(`Ingrese ${clave}`, "error", 1600);
          return;
        }
      }
      this.form.familias.push(this.formFamilia);
      this.showToast("registro agregado, Guarde los cambios", "success", 1600);
      this.clearFormFamilia();
      this.cerrarModal();
    },
    buscarEmpleados() {
      const datos = { opcion: "empleados" };
      axios
        .get(`/rrhh/empleados/${JSON.stringify(datos)}/detail`)
        .then((res) => {
          this.nuevo();
          this.listaEmpleados = res.data;
          this.banderaBtnFamilia = false;
        })
        .catch((err) => this.handleError(err));
    },
    estadoEmpleado(activo) {
      return activo ? "ACTIVO" : "INACTIVO";
    },
    editarEmpleado(datosEmpleado) {
      this.form = datosEmpleado;
      this.listaEmpleados = [];
    },
    datosFamiliares(familares) {
      this.form.familias = familares;
      this.mostrarBtnMas(false);
    },
    nombreC(nombre1, nombre2, nombre3, apellido1, apellido2, apellido3) {
      return (
        nombre1 +
        " " +
        (nombre2 == null ? "" : nombre2) +
        " " +
        (nombre3 == null ? "" : nombre3) +
        " " +
        apellido1 +
        " " +
        apellido2 +
        " " +
        (apellido3 == null ? "" : apellido3)
      );
    },
    nuevo() {
      this.form = {
        cue: null,
        nombre1: null,
        nombre2: null,
        nombre3: null,
        apellido1: null,
        apellido2: null,
        apellido3: null,
        dpi: null,
        genero: [],
        fecha_nacimiento: null,
        direccion: null,
        celular: null,
        telefono: null,
        estado_civil: [],
        puesto: [],
        sueldo: [],
        correo: null,
        activo: true,
        observacion: null,
        familias: [],
        empresa: [],
      };
      this.clearFormFamilia();
      this.listaEmpleados = [];
      this.validationErrors = { form: null };
    },
    clearFormFamilia() {
      this.formFamilia = {
        id: null,
        nombre1: null,
        nombre2: null,
        nombre3: null,
        apellido1: null,
        apellido2: null,
        apellido3: null,
        dpi: null,
        genero: [],
        fecha_nacimiento: null,
        direccion: null,
        celular: null,
        telefono: null,
        estado_civil: [],
        correo: null,
        tipo_familia: [],
      };
      this.banderaFamiliar = false;
    },
    mostrarModalFamilia() {
      $("#modalfamilia").modal("show");
      // $("modalFamilia").modal("handleUpdate");
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