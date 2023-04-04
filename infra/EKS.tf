module "eks" {
  source  = "terraform-aws-modules/eks/aws"

  cluster_name    = var.cluster_name
  cluster_version = "1.24"
  cluster_endpoint_private_access  = true
  #cluster_endpoint_public_access  = true # Se quiser dar acesso publico ao nosso cluster.

  vpc_id                   = module.vpc.vpc_id # Pego la do arquivo GrupoSeguranca
  subnet_ids               = module.vpc.private_subnets
  #control_plane_subnet_ids = ["subnet-xyzde987", "subnet-slkjf456", "subnet-qeiru789"]

  eks_managed_node_groups = {
    alura = {
      min_size     = 1
      max_size     = 10
      desired_size = 3
      vpc_security_group_ids = [aws_security_group.ssh_cluster.id]
      instance_types = ["t2.micro"] # Instancia menor, pois nossa app tem poucas requisições
    }
  }
}