variable "names" {
  type = list(string)
  default = ["rajan", "veda", "yatheen"]
}

variable "actors_of_matrix" {
  type = map(string)
  default = {
    hero = "Neo"
    partner = "Trinity"
    support = "Morpheus"
  }
}

output "upper_names" {
  value = [for name in var.names: upper(name)]
}

output "short_upper_names" {
  value = [for name in var.names: upper(name) if length(name) < 5]
}

output "long_upper_names" {
  value = [for name in var.names: upper(name) if length(name) > 4]
}

output "matrix" {
  value = [for role, name in var.actors_of_matrix: "${name} is the ${role}"]
}

output "matrix_map" {
  value = {for role, name in var.actors_of_matrix: upper(name) => upper(role)}
}


output "for_directive" {
  value = "%{ for name in var.names }${name}, %{ endfor }"
}

output "for_directive_index" {
  value = "%{ for i, name in var.names }(${i}) ${name}, %{ endfor }"
}

output "for_directive_index_if" {
  value = <<EOF
%{~ for i, name in var.names ~}
  ${i}. ${name}%{ if i < length(var.names) - 1 }, %{ else }. %{ endif }
%{~ endfor ~}
EOF
}